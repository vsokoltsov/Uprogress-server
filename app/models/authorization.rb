# frozen_string_literal: true

class Authorization < ApplicationRecord
  belongs_to :user
  has_one :device, dependent: :destroy

  scope :device_tokens, lambda { |platform|
    includes(:device).where(platform: platform).map { |x| x.device&.token }.compact
  }

  scope :android_device_tokens, -> { device_tokens('Android') }

  scope :ios_device_tokens, -> { device_tokens('iOS') }

  def self.decode_jwt_and_find(token)
    find(JWT.decode(token, nil, false).first['id']) if token
  end
end
