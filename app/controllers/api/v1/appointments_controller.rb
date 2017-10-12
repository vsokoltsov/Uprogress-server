# frozen_string_literal: true

class Api::V1::AppointmentsController < Api::ApiController
  before_action :validate_token
  before_action :load_appointment, except: :create

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

  def update
    form = Form::Appointment.new(
      @appointment,
      params[:appointment]&.to_unsafe_hash
    )
    if form.submit
      render json: form.object, serializer: AppointmentSerializer
    else
      render json: { errors: form.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    render json: @appointment, serializer: AppointmentSerializer if @appointment.destroy
  end

  private

  def load_appointment
    @appointment = Appointment.find(params[:id])
  end
end
