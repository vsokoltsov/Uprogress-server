# frozen_string_literal: true

class CurrentUserSerializer < ActiveModel::Serializer
  attributes :id, :email, :nick, :first_name, :last_name, :description, :location

  has_one :attachment, serializer: AttachmentSerializer

  def json_key
    'current_user'
  end
end
