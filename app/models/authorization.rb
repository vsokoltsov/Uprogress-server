# frozen_string_literal: true
class Authorization < ActiveRecord::Base
  belongs_to :user

  def self.find_by_jwt_token(token)
    find(JWT.decode(token, nil, false).first['id']) if token
  end
end
