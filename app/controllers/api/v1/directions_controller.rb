class Api::V1::DirectionsController < Api::ApiController
  def index
    directions = Direction.all
    render json: directions
  end

  def create
    direction = Direction.new(params[:direction].symbolize_keys)
    if direction.save
      render json: { direction: direction }
    else
      render json: { errors: direction.errors }, status: :uprocessable_entity
    end
  end
end
