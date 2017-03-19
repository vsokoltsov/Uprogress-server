class Form::ResetPassword < Form::Base
  include PasswordValidation
  attribute :password
  attribute :password_confirmation
  attribute :token

  validates_confirmation_of :password, if: lambda { |m| m.password.present? }

  def reset
    return unless valid?
    begin
        user = ::User.decode_jwt_and_find(token)
        ActiveRecord::Base.with_advisory_lock("#{user.nick}_reset_password") do
          ActiveRecord::Base.transaction do
            user.update(password: password, password_confirmation: password_confirmation)
          end
        end
        true
    rescue JWT::DecodeError
      errors.add(:token, 'Token is not valid')
    end
  end
end
