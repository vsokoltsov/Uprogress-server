class Form::User < Form::Base
  attribute :email
  attribute :attachment
  attribute :first_name
  attribute :last_name
  attribute :description
  attribute :location

  validates :email, :first_name, :last_name, presence: true

  def attachment=(image)
    if image
      attachment = manage_attachment(image)
      super(attachment)
    end
  end

  private

  def manage_attachment(image)
    attachment = Attachment.find_by(id: image["id"], attachable_type: object.class.to_s)
    attachment.update!(attachable_id: object.id)
    object.attachment = attachment
    attachment
  end
end
