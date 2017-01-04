# frozen_string_literal: true
class DirectionSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :finished_steps_count, :percents_result

  delegate :percents_result, to: :object
  has_many :steps
  has_one :user, serializer: DirectionUserSerializer

  def steps
    object.steps.order(:created_at).limit(10).page(1).per(10)
  end

  def json_key
    'direction'
  end
end
