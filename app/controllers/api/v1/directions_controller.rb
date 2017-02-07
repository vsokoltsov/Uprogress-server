# frozen_string_literal: true
class Api::V1::DirectionsController < Api::ApiController
  before_action :find_user
  before_action :validate_token, except: [:index, :show]

  def index
    directions = @user.directions.limit(10).page(params[:page] || 1).per(10)
    render json: directions, each_serializer: DirectionsSerializer
  end

  def create
    @form = Form::Direction.new(
      current_user.directions.build,
      params[:direction].to_unsafe_hash
    )
    handle_form_submit!
  end

  def show
    direction = @user.directions.friendly.find(params[:id])
    render json: direction, serializer: DirectionSerializer
  end

  def update
    direction = current_user.directions.find(params[:id])
    @form = Form::Direction.new(direction, params[:direction].to_unsafe_hash)
    handle_form_submit!
  end

  private

  def handle_form_submit!
    if @form.submit
      render json: @form.object, serializer: DirectionSerializer
    else
      render json: { errors: @form.errors }, status: :unprocessable_entity
    end
  end
end
