# frozen_string_literal: true
module SessionConcern
  TOKEN_NAME = 'uprogresstoken'
  LOCALE_NAME = 'locale'

  attr_writer :auth_token, :current_user, :current_authorization

  def auth_token
    request.headers[TOKEN_NAME]
  end

  def locale_token
    request.headers[LOCALE_NAME]
  end

  def current_user
    current_authorization.try(:user)
  end

  def current_authorization
    @current_authorization ||= Authorization.find_by_jwt_token(auth_token) rescue nil
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    self.current_user = nil
  end
end
