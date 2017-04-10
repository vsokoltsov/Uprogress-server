# frozen_string_literal: true
class DirectionAppointmentSerializer < ActiveModel::Serializer
  attributes :id, :message, :date, :created_at, :repeats, :next_date

  def next_date
    return nil unless Time.zone.now >= object.date
    if object.never?
      nil
    elsif Time.zone.now.strftime('%H:%M') > object.date.time.strftime('%H:%M')
      "#{Time.zone.today} #{object.date.time.strftime('%H:%M')}".to_datetime
    else
      "#{Time.zone.today + 1.day} #{object.date.time.strftime('%H:%M')}".to_datetime
    end
  end
end
