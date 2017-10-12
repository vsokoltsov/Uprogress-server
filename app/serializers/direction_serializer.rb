# frozen_string_literal: true

class DirectionSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :finished_steps_count,
             :percents_result, :updated_at, :slug

  delegate :percents_result, to: :object
  has_many :steps, serializer: StepsSerializer
  has_one :user, serializer: DirectionUserSerializer
  has_many :appointments, serializer: DirectionAppointmentSerializer

  def steps
    object.steps.order(:created_at)
  end

  def json_key
    'direction'
  end
end
