# frozen_string_literal: true
class User < ActiveRecord::Base
  has_many :authorization

  has_secure_password
end
