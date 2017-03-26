# frozen_string_literal: true
class Service::Notification::Ios < Service::Notification::Base
  attr_accessor :ios

  def initialize(user)
    super
    @ios = Service::IosClient.new(ENV['IOS_CERTIFICATE_NAME'])
  end

  def push_notification(devices_ids, message)
    ios.send_request(devices_ids, message)
  end
end
