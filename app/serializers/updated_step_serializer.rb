# frozen_string_literal: true
class UpdatedStepSerializer < ActiveModel::Serializer
  # root 'step'
  attributes :id, :title, :description, :is_done

  has_one :direction, serializer: DirectionSerializer

  def json_key
    'step'
  end
end
