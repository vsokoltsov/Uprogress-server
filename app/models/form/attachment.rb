class Form::Attachment < Form::Base
  attribute :attachable_id
  attribute :attachable_type
  attribute :file

  validates :attachable_type, :file, presence: true

  def submit
    return unless valid?
    object.assign_attributes(attributes)
    object.save!
    if attributes[:attachable_id]
      entity = attributes[:attachable_type].constantize
                .find(attributes[:attachable_id])
      entity.attachment.destroy!
      entity.update(attachment: object)
      entity.reload
    end
    true
  end
end
