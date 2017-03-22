# frozen_string_literal: true
class Service::AndroidClient
  DEFAULT_TITLE = 'UProgress'
  FIREBASE_URL = 'https://fcm.googleapis.com/fcm/send'
  attr_accessor :api_key

  def initialize(api_key)
    @api_key = api_key
  end

  def send_request(devices_ids, body_message, title = nil)
    RestClient.post(FIREBASE_URL, body(
      devices_ids,
      body_message, title || DEFAULT_TITLE
    ).to_json,
                    headers)
  end

  private

  def headers
    {
      'Content-Type': 'application/json',
      'Authorization': "key=#{api_key}"
    }
  end

  def body(devices_ids, body_message, title)
    {
      'registration_ids': devices_ids,
      'data': {
        'title': title,
        'body': body_message
      }
    }
  end
end
