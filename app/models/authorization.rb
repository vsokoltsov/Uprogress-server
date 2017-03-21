# frozen_string_literal: true
class Authorization < ActiveRecord::Base
  belongs_to :user
  has_one :device

  scope :android_device_tokens, lambda {
    includes(:device).where(platform: 'Android').map { |x| x.device.token }
  }

  def self.decode_jwt_and_find(token)
    find(JWT.decode(token, nil, false).first['id']) if token
  end
end
