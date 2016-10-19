# frozen_string_literal: true
class Api::V1::UsersController < Api::ApiController
  def show
    user = User.find(params[:id])
    render json: user, serializer: UserSerializer
  end

  def update
    user = User.find(params[:id])
    form = Form::User.new(user, params[:user].permit!)
    if form.submit
      render json: user, serializer: CurrentUserSerializer
    else
      render json: { errors: form.errors }, status: :unprocessable_entity
    end
  end

  def statistics
    user = User.find(params[:id])
    render json: user, serializer: StatisticsSerializer
  end
end
