# frozen_string_literal: true

class UserMailer < ActionMailer::Base
  layout 'mailer'
  default from: 'uprogress@support.com'

  def restore_password(user, token)
    @user = user
    @token = token
    @host = ENV['CLIENT_HOST']
    mail to: @user.email
  end
end
