# frozen_string_literal: true
class Api::V1::DevicesController < Api::ApiController
  before_action :validate_token

  def create
    form = Form::Device.new(
      params[:device].merge!(authorizaiton_id: current_authorization.id)
    )
    if form.submit
      render json: { success: true }
    else
      render json: { errors: form.errors }, status: :unprocessable_entity
    end
  end
end
