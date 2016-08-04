class UpdatedStepSerializer < ActiveModel::Serializer
  root 'step'
  attributes :id, :title, :description, :is_done

  has_one :direction, serializer: DirectionSerializer
end
