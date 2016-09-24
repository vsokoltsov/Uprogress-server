# frozen_string_literal: true
class UserSerializer < ActiveModel::Serializer
  root 'user'
  attributes :id, :nick, :first_name, :last_name, :description, :location,
             :finished_directions, :new_directions, :recent_actions

  has_many :directions, serializer: DirectionsSerializer
  has_one :attachment, serializer: AttachmentSerializer

  def finished_directions
    scope.directions.select do |attr|
      steps_status = attr.steps.map(&:is_done)
      steps_status.uniq.length == 1 && steps_status.first
    end.first(5)
  end

  def new_directions
    scope.directions.select do |attr|
      attr.steps.blank?
    end.first(5)
  end

  def recent_actions
    logs = object.system_logs.limit(5).group_by do |item|
      item.created_at.to_date
    end
    Hash[*logs.flatten]
  end
end
