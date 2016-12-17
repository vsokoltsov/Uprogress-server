class Form::User < Form::Base
  attribute :email
  attribute :attachment
  attribute :first_name
  attribute :last_name
  attribute :description
  attribute :location

  validates :email, :first_name, :last_name, presence: true

  def attachment=(image)
    super(Attachment.find_by(id: image["id"], attachable_type: object.class.to_s))
  end
end
