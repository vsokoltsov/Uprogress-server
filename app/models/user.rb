# frozen_string_literal: true
class User < ActiveRecord::Base
  extend FriendlyId

  has_many :authorization
  has_many :directions
  has_one :attachment, as: :attachable, dependent: :destroy

  has_secure_password

  friendly_id :nick, use: :finders
end
