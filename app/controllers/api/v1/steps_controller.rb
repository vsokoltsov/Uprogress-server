# frozen_string_literal: true
class Api::V1::StepsController < Api::ApiController
  before_action :validate_token

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
    step = Step.find(params[:id])
    form = Form::Step.new(step, params[:step])
    if form.submit
      render json: form.object, serializer: UpdatedStepSerializer
    else
      render json: { errors: form.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    step = Step.find(params[:id])
    render json: step, serializer: UpdatedStepSerializer if step.destroy
  end
end
