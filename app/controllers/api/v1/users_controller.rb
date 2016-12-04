# frozen_string_literal: true
class Api::V1::UsersController < Api::ApiController
  before_action :validate_token, only: :update
  before_action :find_user

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

  private

  def find_user
    @user = User.friendly.find(params[:id])
  end
end
