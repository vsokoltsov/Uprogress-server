class Form::ResetPassword < Form::Base
  attr_accessor :user
  include PasswordValidation
  attribute :password
  attribute :password_confirmation
  attribute :token

  validates_confirmation_of :password, if: lambda { |m| m.password.present? }
  validate :token_expired?
  validate :password_equal_to_previous_password?

  def initialize(params = nil)
    self.attributes = params
    @user = ::User.decode_jwt_and_find(token)
  end

  def reset
    return unless valid?
    begin
        ::Service::TransactionLock.run_with_message("#{user.nick}_reset_password") do
          user.update(
            password: password,
            password_confirmation: password_confirmation,
            reset_password_token: nil)
        end
        true
    rescue JWT::DecodeError
      errors.add(:token, 'Token is not valid')
    end
  end

  private

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
