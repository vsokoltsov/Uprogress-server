# frozen_string_literal: true
class Service::PushNotifications
  attr_accessor :user

  def initialize(user)
    @user = user
  end

  def send_notification(message, title = nil)
    create_android_client!(message, title) if android_tokens
  end

  private

  def android_tokens
    @android_tokens ||= user.authorizations.android_device_tokens
  end

  def create_android_client!(message, title = nil)
    Notification::Android.new(user).push_notification(android_tokens, message, title)
  end
end
