class Api::V1::StepsController < Api::ApiController

  def create
    direction = Direction.find(params[:direction_id])
    form = Form::Step.new(direction.steps.build, params[:step])
    if form.submit
      render json: form.object, serializer: UpdatedStepSerializer
    else
      render json: { errors: form.errors }, status: :unprocessable_entity
    end
  end

  def update
    direction = Direction.find(params[:direction_id])
    step = Step.find(params[:id])
    form = Form::Step.new(step, params[:step])
    if form.submit
      render json: form.object, serializer: UpdatedStepSerializer
    else
      render json: { errors: form.errors }
    end
  end
end
