# frozen_string_literal: true
class Api::V1::StepsController < Api::ApiController
  before_action :validate_token, except: :index

  def index
    direction = Direction.find(params[:direction_id])
    steps = direction.steps.page(params[:page] || 1).per(10)
    render json: steps, each_serializer: StepSerializer
  end

  def create
    direction = Direction.find(params[:direction_id])
    @form = Form::Step.new(direction.steps.build, params[:step].to_unsafe_hash)
    handle_form_submit!
  end

  def update
    step = Step.find(params[:id])
    @form = Form::Step.new(step, params[:step].to_unsafe_hash)
    handle_form_submit!
  end

  def destroy
    step = Step.find(params[:id])
    render json: step, serializer: StepSerializer if step.destroy
  end

  private

  def handle_form_submit!
    if @form.submit
      render json: @form.object, serializer: StepSerializer
    else
      render json: { errors: @form.errors }, status: :unprocessable_entity
    end
  end
end
