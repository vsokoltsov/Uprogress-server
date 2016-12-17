class Form::Step < Form::Base
  OPERATION_DECREASE = '-'
  OPERATION_INCREASE = '+'
  attribute :title
  attribute :is_done
  attribute :description

  validates :title, :description, presence: true

  def submit
    super do
      update_finished_steps!
    end
  end

  private

  def update_finished_steps!
    if @operation.eql?('update') && @object.previous_changes.has_key?('is_done')
      direction = @object.direction
      operation = @object.is_done ? OPERATION_INCREASE : OPERATION_DECREASE
      finished_steps_count = direction.finished_steps_count.send(operation, 1)
      direction.update(finished_steps_count: finished_steps_count) if finished_steps_count >= 0
    end
  end
end
