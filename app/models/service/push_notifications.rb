# frozen_string_literal: true

class Service::PushNotifications
  attr_accessor :user

  def initialize(user)
    @user = user
  end

  def send_notification(message, title = nil)
    create_android_client!(message, title) if android_tokens.present?
    create_ios_client!(message, title) if ios_tokens.present?
  end

  private

  def android_tokens
    @android_tokens ||= user.authorizations.android_device_tokens
  end

  def ios_tokens
    @ios_tokens ||= user.authorizations.ios_device_tokens
  end

  def create_android_client!(message, title = nil)
    ::Service::Notification::Android.new(user).push_notification(android_tokens, message, title)
  end

  def create_ios_client!(message, title = nil)
    ::Service::Notification::Ios.new(user).push_notification(ios_tokens, message, title)
  end
end
