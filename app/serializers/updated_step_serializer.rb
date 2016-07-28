class UpdatedStepSerializer < ActiveModel::Serializer
  root 'step'
  attributes :title, :result, :is_done

  has_one :direction, serializer: DirectionSerializer
end
