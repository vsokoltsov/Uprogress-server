# frozen_string_literal: true
class UserScope
  attr_accessor :user

  def initialize(user)
    self.user = user
  end

  def finished_directions
    @user.directions.select do |attr|
      steps_status = attr.steps.map(&:is_done)
      steps_status.uniq.length == 1 && steps_status.first
    end
  end

  def new_directions
    @user.directions.select do |attr|
      attr.steps.blank?
    end
  end

  def in_progress_directions
    @user.directions.select do |item|
      steps_status = item.steps.map(&:is_done)
      steps_status.uniq.size > 1 || !steps_status.first.nil?
    end
  end
end
