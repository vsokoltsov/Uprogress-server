# frozen_string_literal: true
class Service::Notification::Android < Service::Notification::Base
  attr_accessor :android

  def initialize(user)
    super
    @android = Service::AndroidClient.new(ENV['FIREBASE_API_KEY'])
  end

  def push_notification(devices_ids, message, title = nil)
    android.send_request(devices_ids, message, title)
  end
end
