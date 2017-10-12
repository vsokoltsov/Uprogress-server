# frozen_string_literal: true

class Api::V1::UsersController < Api::ApiController
  before_action :validate_token, only: %i[update change_password]
  before_action :find_user, except: :change_password

  def show
    render json: @user, serializer: UserSerializer
  end

  def update
    form = Form::User.new(@user, params[:user]&.to_unsafe_hash)
    if form.submit
      render json: form.object, serializer: CurrentUserSerializer
    else
      render json: { errors: form.errors }, status: :unprocessable_entity
    end
  end

  def statistics
    render json: @user, serializer: StatisticsSerializer
  end

  def change_password
    form = Form::ResetPassword.new(current_user, params[:user]&.to_unsafe_hash)
    if form.reset
      render json: form.user, serializer: CurrentUserSerializer
    else
      render json: { errors: form.errors }, status: :unprocessable_entity
    end
  end

  private

  def find_user
    @user = User.friendly.find(params[:id])
  end
end
