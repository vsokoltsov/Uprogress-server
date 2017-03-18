# frozen_string_literal: true
class UserMailer < ActionMailer::Base
  default from: 'uprogress@support.com'

  def restore_password(user)
    @user = user
    mail to: @user.email
  end
end
