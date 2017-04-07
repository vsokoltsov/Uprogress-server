# frozen_string_literal: true
class AppointmentSerializer < ActiveModel::Serializer
  attributes :id, :message, :date, :created_at

  has_one :direction, serializer: DirectionSerializer
end
