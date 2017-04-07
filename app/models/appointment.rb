# frozen_string_literal: true
class Appointment < ActiveRecord::Base
  belongs_to :direction
end
