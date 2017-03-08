class Form::Attachment < Form::Base
  attribute :attachable_id
  attribute :attachable_type
  attribute :file

  validates :attachable_type, :file, presence: true

  def submit
    super do
      if attributes[:attachable_id]
        attributes[:attachable_type].constantize
                  .find(attributes[:attachable_id])
                  .update(attachment: object)
      end
    end
  end
end
