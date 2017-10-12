# frozen_string_literal: true

class SystemLog < ApplicationRecord
  belongs_to :user
  store_accessor :data
end
