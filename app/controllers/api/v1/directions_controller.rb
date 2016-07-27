class Api::V1::DirectionsController < Api::ApiController
  def index
    directions = Direction.all
    render json: directions, each_serializer: DirectionsSerializer
  end

  def create
    form = Form::Direction.new(Direction.new, params[:direction])
    if form.submit
      render json: { direction: form.object }
    else
      render json: { errors: form.errors }, status: :uprocessable_entity
    end
  end

  def show
    direction = Direction.find(params[:id])
    render json: { direction: direction }
  end

  def update
    direction = Direction.find(params[:id])
    form = Form::Direction.new(direction, params[:direction])
    if form.submit
      render json: { direction: form.object }
    else
      render json: { errors: form.errors }, status: :uprocessable_entity
    end
  end
end
