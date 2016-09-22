class Form::User < Form::Base
  attribute :email
  attribute :attachment

  def attachment=(image)
    super(Attachment.find_by(id: image["id"], attachable_type: @object.class.to_s))
  end
end
