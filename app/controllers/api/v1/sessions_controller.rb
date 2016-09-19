# frozen_string_literal: true
class Api::V1::SessionsController < Api::ApiController
  def create
    form = Form::Session.new(nil, params[:user])
    if form.submit
      render json: { token: form.token }
    else
      render json: { errors: form.errors }, status: :unprocessable_entity
    end
  end
end
