# frozen_string_literal: true

class Service::IosClient
  attr_accessor :apn

  def initialize(file_name)
    correct_env = ENV['RAILS_ENV'] == 'test' ? 'development' : ENV['RAILS_ENV']
    @apn = Houston::Client.send(correct_env.to_sym)
    apn.certificate = File.read(Rails.root.join('config', 'certificates', file_name))
  end

  def send_request(device_tokens, body, title = nil)
    device_tokens.each do |token|
      send_single_request(token, body, title)
    end
  end

  def send_single_request(token, body, title = nil)
    notification = Houston::Notification.new(device: token)
    message = {}
    message['body'] = body
    message['title'] = title if title
    notification.alert = message
    notification.sound = 'sosumi.aiff'
    notification.content_available = true
    notification.mutable_content = true
    apn.push(notification)
  end
end
