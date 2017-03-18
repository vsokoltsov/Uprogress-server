class Form::RestorePassword < Form::Base
  attribute :email

  def restore
    user = ::User.find_by(email: email)
    if user
      ::UserMailer.delay.restore_password(user)
      true
    else
      false
    end
  end
end
