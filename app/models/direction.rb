# frozen_string_literal: true
class Direction < ActiveRecord::Base
  has_many :steps

  def percents_result
    steps_count = steps.size
    completed_steps = steps.completed.size
    (completed_steps / steps_count.to_f * 100).to_i if steps.present?
  end
end
