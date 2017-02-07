# frozen_string_literal: true
class StepsSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :direction_id, :is_done, :updated_at
end
