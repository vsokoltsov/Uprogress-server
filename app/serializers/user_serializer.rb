# frozen_string_literal: true
class UserSerializer < ActiveModel::Serializer
  attr_accessor :query_scope
  attributes :id, :nick, :first_name, :last_name, :description, :location,
             :finished_directions, :new_directions, :recent_actions

  delegate :directions, :finished_directions, :new_directions, to: :query_scope

  has_many :directions, serializer: DirectionsSerializer
  has_one :attachment, serializer: AttachmentSerializer

  def query_scope
    @query_scope ||= UserDirectionsScope.new(object)
  end

  def recent_actions
    logs = sorted_logs(object).group_by do |item|
      item.created_at.to_date
    end

    Hash[*logs.flatten]
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
