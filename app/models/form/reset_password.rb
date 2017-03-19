class Form::ResetPassword < Form::Base
  attr_accessor :user
  include PasswordValidation
  attribute :password
  attribute :password_confirmation
  attribute :token

  validates_confirmation_of :password, if: lambda { |m| m.password.present? }
  with_options if: :decrypted_token? do |user|
    user.validate :token_expired?
    user.validate :password_equal_to_previous_password?
  end


  def initialize(params = nil)
    self.attributes = params
  end

  def reset
    return unless valid?
    ::Service::TransactionLock.run_with_message("#{user.nick}_reset_password") do
      user.update(
        password: password,
        password_confirmation: password_confirmation,
        reset_password_token: nil)
    end
    true
  end

  private

  def decrypted_token?
    begin
      @user = ::User.decode_jwt_and_find(token)
      true
    rescue JWT::DecodeError
      errors.add(:token, 'Token is not valid')
      false
    end
  end

  def token_expired?
    unless user.reset_password_token == token
      errors.add(:token, 'Token has expired')
    end
  end

  def password_equal_to_previous_password?
    current_password = BCrypt::Password.new(user.password_digest)
    if current_password == password
      errors.add(:password, 'Equal to previous password')
    end
  end
end
