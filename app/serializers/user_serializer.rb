# frozen_string_literal: true
class UserSerializer < ActiveModel::Serializer
  attributes :id, :nick, :first_name, :last_name, :description, :location,
             :finished_directions, :new_directions, :recent_actions

  has_many :directions, serializer: DirectionsSerializer
  has_one :attachment, serializer: AttachmentSerializer

  def finished_directions
    Direction.joins(:steps).where(user_id: object.id).select do |attr|
      steps_status = attr.steps.map(&:is_done)
      steps_status.uniq.size == 1 && steps_status.first
    end.first(5)
  end

  def new_directions
    Direction.joins(:steps).where(user_id: object.id)
             .group('directions.id, steps.id').having('COUNT(steps) > 0')
             .uniq.limit(5)
  end

  def recent_actions
    logs = sorted_logs(object).group_by do |item|
      item.created_at.to_date
    end

    Hash[*logs.flatten]
  end

  def directions
    Direction.where(user_id: object.id)
  end

  def json_key
    'user'
  end

  private

  def sorted_logs(object)
    object.system_logs
          .order(created_at: :desc)
          .limit(5)
          .sort do |a, b|
            b.created_at <=> a.created_at
          end
  end
end
