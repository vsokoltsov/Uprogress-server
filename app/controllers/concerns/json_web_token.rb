# frozen_string_literal: true
module JsonWebToken
  USER_NOT_FOUND = 'User not found'
  TOKEN_INVALID = 'Authorization token invalid'
  TOKEN_EXPIRED = 'Authorization token expired'

  def validate_token
    current_authorization = Authorization.find_by_jwt_token(auth_token)
    store_current_user
    raise ActiveRecord::RecordNotFound if current_authorization.blank?
  rescue ActiveRecord::RecordNotFound
    raise Api::Error.new(USER_NOT_FOUND, 401)
  rescue JWT::DecodeError
    raise Api::Error.new(TOKEN_INVALID, 401)
  rescue JWT::ExpiredSignature
    raise Api::Error.new(TOKEN_EXPIRED, 401)
  end

  def jwt_secret
    Rails.application.secrets.jwt_secret
  end

  def generate_token_for_auth(auth)
    JWT.encode({ id: auth.id }, jwt_secret, 'HS256')
  end

  def store_current_user
    if SessionConcern::LOGGED_REQUESTS.include?(request.method)
      RequestStore.store[:current_user] = current_user
    end
  end
end
