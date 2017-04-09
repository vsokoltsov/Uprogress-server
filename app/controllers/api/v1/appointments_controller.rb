# frozen_string_literal: true
class Api::V1::AppointmentsController < Api::ApiController
  before_action :validate_token

  def create
    form = Form::Appointment.new(
      Appointment.new,
      params[:appointment]&.to_unsafe_hash
    )
    if form.submit
      render json: form.object, serializer: AppointmentSerializer
    else
      render json: { errors: form.errors }, status: :unprocessable_entity
    end
  end
end
