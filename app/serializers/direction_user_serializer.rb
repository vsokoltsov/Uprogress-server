# frozen_string_literal: true

class DirectionUserSerializer < ActiveModel::Serializer
  attributes :id, :nick, :first_name, :last_name, :description, :location

  has_one :attachment, serializer: AttachmentSerializer
end
