# frozen_string_literal: true
class DirectionSerializer < ActiveModel::Serializer
  # root 'direction'
  attributes :id, :title, :description, :percents_result

  delegate :percents_result, to: :object
  has_many :steps
  has_one :user

  def steps
    object.steps.order(:created_at)
  end

  def json_key
    'direction'
  end
end
