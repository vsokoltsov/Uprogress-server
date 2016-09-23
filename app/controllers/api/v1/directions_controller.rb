# frozen_string_literal: true
class Api::V1::DirectionsController < Api::ApiController
  before_action :find_user
  before_action :validate_token, except: [:index, :show]

  def index
    directions = @user.directions
    render json: directions, each_serializer: DirectionsSerializer
  end

  def create
    form = Form::Direction.new(current_user.directions.build, params[:direction])
    if form.submit
      render json: form.object, serializer: DirectionSerializer
    else
      render json: { errors: form.errors }, status: :unprocessable_entity
    end
  end

  def show
    direction = @user.directions.find(params[:id])
    render json: direction, serializer: DirectionSerializer
  end

  def update
    direction = current_user.directions.find(params[:id])
    form = Form::Direction.new(direction, params[:direction])
    if form.submit
      render json: form.object, serializer: DirectionSerializer
    else
      render json: { errors: form.errors }, status: :unprocessable_entity
    end
  end
end
