# frozen_string_literal: true
class Appointment < ActiveRecord::Base
  belongs_to :direction

  enum repeats: [:never, :every_day]
end
