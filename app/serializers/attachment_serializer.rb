# frozen_string_literal: true

class AttachmentSerializer < ActiveModel::Serializer
  attributes :id, :attachable_id, :attachable_type, :created_at, :url

  def url
    object.file.url
  end
end
