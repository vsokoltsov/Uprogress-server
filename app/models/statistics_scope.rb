# frozen_string_literal: true
class StatisticsScope
  attr_accessor :user

  MAIN_COLOR = '#3366CC'
  SECONDARY_COLOR = '#DC3912'
  LAST_COLOR = '#FF9900'

  def initialize(user)
    self.user = user
  end

  def directions
    directions_count = @user.directions.size.to_f
    if directions_count.positive?
      in_progress_directions = count_percents(@user.in_progress_directions, directions_count)
      new_directions = count_percents(@user.new_directions, directions_count)
      finished_directions = count_percents(@user.finished_directions, directions_count)
      [
        { label: 'In progress', value: in_progress_directions.to_f, color: MAIN_COLOR },
        { label: 'New directions', value: new_directions.to_f, color: SECONDARY_COLOR },
        { label: 'Finished directions', value: finished_directions.to_f, color: LAST_COLOR }
      ]
    else
      []
    end
  end

  def steps
    steps_list_for_directions = @user.directions.map(&:steps).flatten
    steps_list_for_directions.group_by(&:is_done).map do |item|
      case item.first
      when true
        hash = { label: 'Finished', color: MAIN_COLOR }
      when false
        hash = { label: 'Cancelled', color: SECONDARY_COLOR }
      when nil
        hash = { label: 'In progress', color: LAST_COLOR }
      end
      hash[:value] = ((item.last.size / steps_list_for_directions.size.to_f) * 100).round(2)
      hash
    end
  end

  def directions_steps
    directions_steps_size = @user.directions.map(&:steps).flatten.size
    directions = @user.directions
    directions.map do |item|
      {
        label: item.title,
        color: Faker::Color.hex_color,
        value: ((item.steps.size / directions_steps_size.to_f) * 100).round(2)
      }
    end
  end

  private

  def count_percents(directions, amount)
    (directions.size / amount) * 100
  end
end
