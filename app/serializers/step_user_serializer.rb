# frozen_string_literal: true

class StepUserSerializer < ActiveModel::Serializer
  attributes :id, :nick, :first_name, :last_name, :description, :location
end
