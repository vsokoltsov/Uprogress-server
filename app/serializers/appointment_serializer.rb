# frozen_string_literal: true
class AppointmentSerializer < ActiveModel::Serializer
  attributes :id, :message, :date, :created_at

  has_one :dirrection, serializer: DirectionSerializer
end
