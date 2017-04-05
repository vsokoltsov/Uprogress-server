# frozen_string_literal: true
class Api::V1::DevicesController < Api::ApiController
  before_action :validate_token

  def create
    form = Form::Device.new(device_attirbutes)
    if form.submit
      render json: { success: true }
    else
      render json: { errors: form.errors }, status: :unprocessable_entity
    end
  end

  private

  def device_attirbutes
    params[:device]&.to_unsafe_hash
          &.merge!(authorization_id: current_authorization.id)
          &.symbolize_keys || {}
  end
end
