class DirectionSerializer < ActiveModel::Serializer
  root 'direction'
  attributes :id, :title, :description, :percents_result

  delegate :percents_result, to: :object
  has_many :steps
end
