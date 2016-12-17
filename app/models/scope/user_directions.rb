# frozen_string_literal: true
class Scope::UserDirections
  attr_accessor :user

  def initialize(user)
    self.user = user
  end

  def finished_directions
    Direction.joins(:steps).where(user_id: @user.id).uniq!.select do |attr|
      steps_status = attr.steps.map(&:is_done)
      steps_status.uniq.size == 1 && steps_status.first
    end.first(5)
  end

  def new_directions
    Direction.joins(:steps).where(user_id: @user.id)
             .group('directions.id, steps.id').having('COUNT(steps) > 0')
             .uniq.limit(5)
  end

  def directions
    Direction.where(user_id: @user.id)
  end
end
