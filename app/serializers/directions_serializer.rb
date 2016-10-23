# frozen_string_literal: true
class DirectionsSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :percents_result

  delegate :percents_result, to: :object
end
