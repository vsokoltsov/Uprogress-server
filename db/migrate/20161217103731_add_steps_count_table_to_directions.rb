# frozen_string_literal: true
class AddStepsCountTableToDirections < ActiveRecord::Migration[5.0]
  def change
    add_column :directions, :steps_count, :integer, default: 0, index: true, null: false
    add_column :directions, :finished_steps_count, :integer, default: 0, index: true, null: false

    Direction.all.each do |direction|
      steps_count = direction.steps.size
      finished_steps_count = direction.steps.select(&:is_done).size
      direction.update(steps_count: steps_count, finished_steps_count: finished_steps_count)
    end
  end
end
