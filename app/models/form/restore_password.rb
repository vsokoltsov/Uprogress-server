class Form::RestorePassword < Form::Base
  include JsonWebToken
  attr_accessor :token
  attribute :email

  validates :email, presence: true

  def restore
    return unless valid?
    user = ::User.find_by(email: email)

    if user
      ::Service::TransactionLock.run_with_message("#{user.nick}_reset_password") do
        @token = generate_token_for_user(user)
        user.update(reset_password_token: token)
        ::UserMailer.delay.restore_password(user, token)
      end
      true
    else
      errors.add(:email, 'There is no such user')
      false
    end
  end
end
