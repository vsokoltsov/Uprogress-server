class Form::Attachment < Form::Base
  attribute :attachable_id
  attribute :attachable_type
  attribute :file

  validates :attachable_type, :file, presence: true

  def attributes=(attrs)
    super(attrs)
  end
end
