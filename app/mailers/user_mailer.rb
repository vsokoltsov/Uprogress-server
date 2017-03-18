# frozen_string_literal: true
class UserMailer < ActionMailer::Base
  include JsonWebToken
  layout 'mailer'
  default from: 'uprogress@support.com'

  def restore_password(user)
    @user = user
    @token = generate_token_for_user(@user)
    @host = ENV['CLIENT_HOST']
    mail to: @user.email
  end
end
