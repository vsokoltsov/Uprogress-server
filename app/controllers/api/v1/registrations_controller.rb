# frozen_string_literal: true
class Api::V1::RegistrationsController < Api::ApiController
  def create
    form = Form::Registration.new(User.new, params[:user].to_unsafe_hash)
    if form.submit
      render json: { token: form.token }
    else
      render json: { errors: form.errors }, status: :unprocessable_entity
    end
  end
end
