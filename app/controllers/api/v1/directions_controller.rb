class Api::V1::DirectionsController < Api::ApiController
  def index
    directions = Direction.all
    render json: directions
  end
end
