# frozen_string_literal: true
class Service::IosClient
  attr_accessor :apn

  def initialize(file_name)
    @apn = Houston::Client.development
    apn.certificate = File.read(Rails.root.join('config', 'certificates', file_name))
  end

  def send_request(device_tokens, body)
    device_tokens.each do |token|
      notification = Houston::Notification.new(device: token)
      notification.alert = body
      notification.content_available = true
      notification.mutable_content = true
      apn.push(notification)
    end
  end
end
