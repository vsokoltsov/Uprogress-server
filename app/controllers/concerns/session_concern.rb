# frozen_string_literal: true

module SessionConcern
  TOKEN_NAME = 'uprogresstoken'
  LOCALE_NAME = 'locale'
  LOGGED_REQUESTS = %w[POST PUT DELETE].freeze

  attr_writer :auth_token, :current_user, :current_authorization

  def auth_token
    request.headers[TOKEN_NAME]
  end

  def locale_token
    request.headers[LOCALE_NAME]
  end

  def current_user
    @current_user ||= current_authorization.try(:user)
  end

  def current_authorization
    @current_authorization ||= Authorization.decode_jwt_and_find(auth_token)
  rescue JWT::DecodeError
    nil
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    self.current_user = nil
  end
end
