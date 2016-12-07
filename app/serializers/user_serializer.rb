# frozen_string_literal: true
class UserSerializer < ActiveModel::Serializer
  attr_accessor :query_scope
  attributes :id, :nick, :first_name, :last_name, :description, :location,
             :finished_directions, :new_directions, :recent_actions

  delegate :directions, :finished_directions, :new_directions, to: :directions_scope
  delegate :recent_actions, to: :logs_scope

  has_many :directions, serializer: DirectionsSerializer
  has_one :attachment, serializer: AttachmentSerializer

  def directions_scope
    @directions ||= UserDirectionsScope.new(object)
  end

  def logs_scope
    @logs_scope ||= LogsScope.new(object)
  end

  def json_key
    'user'
  end
end
