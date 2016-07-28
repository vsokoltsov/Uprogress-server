class DirectionSerializer < ActiveModel::Serializer
  root 'direction'
  attributes :id, :title, :description, :percents_result

  delegate :percents_result, to: :object
  has_many :steps

  def steps
    object.steps.order(:created_at)
  end
end
