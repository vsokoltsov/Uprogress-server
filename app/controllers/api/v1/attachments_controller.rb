# frozen_string_literal: true

class Api::V1::AttachmentsController < Api::ApiController
  def create
    form = Form::Attachment.new(Attachment.new, attachment_attributes)
    if form.submit
      render json: form.object, serializer: AttachmentSerializer, status: :ok
    else
      render json: form.errors.as_json, status: :unprocessable_entity
    end
  end

  private

  def attachment_attributes
    {
      file: params[:file],
      attachable_type: params[:attachable_type],
      attachable_id: params[:attachable_id]
    }
  end
end
