# frozen_string_literal: true
class Api::V1::SessionsController < Api::ApiController
  def create
    form = Form::Session.new(nil, params[:user]&.to_unsafe_hash)
    if form.submit
      render json: { token: form.token }
    else
      render json: { errors: form.errors }, status: :unprocessable_entity
    end
  end

  def current
    if current_user
      render json: current_user, serializer: CurrentUserSerializer
    else
      render json: { user: nil }, status: :unauthorized
    end
  end

  def restore_password
    form = Form::RestorePassword.new(nil, params[:user]&.to_unsafe_hash)
    if form.restore
      render json: { token: form.token, message: 'Mail was succesfully sended' }
    else
      render json: { errors: form.errors }, status: :unprocessable_entity
    end
  end

  def reset_password
    form = Form::ResetPassword.new(params[:user]&.to_unsafe_hash)
    if form.reset
      render json: { message: 'Password was succesfully updated' }
    else
      render json: { errors: form.errors }, status: :unprocessable_entity
    end
  end
end
