# frozen_string_literal: true
class UserSerializer < ActiveModel::Serializer
  root 'user'
  attributes :id, :nick, :first_name, :last_name, :description, :location,
             :finished_directions, :new_directions

  has_many :directions, serializer: DirectionsSerializer
  has_one :attachment, serializer: AttachmentSerializer

  def finished_directions
    scope.directions.select do |attr|
      attr.steps.map(&:is_done).uniq.length == 1
    end.first(5)
  end

  def new_directions
    scope.directions.select do |attr|
      attr.steps.blank?
    end.first(5)
  end
end
