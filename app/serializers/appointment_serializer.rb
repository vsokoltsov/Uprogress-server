# frozen_string_literal: true
class AppointmentSerializer < ActiveModel::Serializer
  attributes :id, :message, :date, :created_at, :repeats

  has_one :direction, serializer: DirectionSerializer

  def json_key
    'appointment'
  end
end
