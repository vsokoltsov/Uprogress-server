class DirectionsSerializer < ActiveModel::Serializer
  root 'directions'
  attributes :id, :title, :description, :percents_result

  delegate :percents_result, to: :object
end
