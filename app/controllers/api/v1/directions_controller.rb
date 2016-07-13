class Api::V1::DirectionsController < Api::ApiController
  def index
    directions = Direction.all
    render json: directions
  end

  def create
    form = Form::Direction.new(Direction.new, params[:direction])
    if form.submit
      render json: { direction: form.object }
    else
      render json: { errors: form.errors }, status: :uprocessable_entity
    end
  end
end
