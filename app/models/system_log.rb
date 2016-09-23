# frozen_string_literal: true
class SystemLog < ActiveRecord::Base
  belongs_to :user
  store_accessor :data
end
