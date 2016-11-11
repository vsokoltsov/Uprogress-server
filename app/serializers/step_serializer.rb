# frozen_string_literal: true
class StepSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :is_done, :direction_id

  belongs_to :direction

  def direction
    DirectionSerializer.new(object.direction).serializable_hash
  end

  def json_key
    'step'
  end
end
