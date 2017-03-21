# frozen_string_literal: true
class Authorization < ActiveRecord::Base
  belongs_to :user
  has_one :device

  def self.decode_jwt_and_find(token)
    find(JWT.decode(token, nil, false).first['id']) if token
  end
end
