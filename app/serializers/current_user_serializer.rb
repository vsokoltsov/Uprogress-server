# frozen_string_literal: true
class CurrentUserSerializer < ActiveModel::Serializer
  root 'current_user'

  attributes :id, :email, :nick, :first_name, :last_name, :description

  has_one :attachment, serializer: AttachmentSerializer
end
