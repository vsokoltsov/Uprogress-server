# frozen_string_literal: true
class Appointment < ActiveRecord::Base
  belongs_to :direction

  enum repeats: [:never, :every_day]

  def start_date_valid?
    Time.zone.today >= date.to_date
  end

  def repeats_to_class_name
    repeats.split('_').map(&:capitalize).join('')
  end
end
