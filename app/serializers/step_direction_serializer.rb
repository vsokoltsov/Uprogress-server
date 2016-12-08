# frozen_string_literal: true
class StepDirectionSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :percents_result

  delegate :percents_result, to: :object
  has_many :steps
  has_one :user, serializer: StepUserSerializer

  def steps
    object.steps.order(:created_at)
  end

  def json_key
    'direction'
  end
end
