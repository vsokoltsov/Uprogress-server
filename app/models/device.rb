# frozen_string_literal: true
class Device < ActiveRecord::Base
  belongs_to :authorization
end
