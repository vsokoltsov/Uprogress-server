class DirectionsSerializer < ActiveModel::Serializer
  root 'directions'
  attributes :title, :description
end
