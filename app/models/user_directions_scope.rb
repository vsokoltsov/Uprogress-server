# frozen_string_literal: true
class UserDirectionsScope
  attr_accessor :user

  def initialize(user)
    self.user = user
  end

  def directions
    directions_count = @user.directions.size.to_f
    if directions_count.positive?
      in_progress_directions = (@user.in_progress_directions.size / directions_count) * 100
      new_directions = (@user.new_directions.size / directions_count) * 100
      finished_directions = (@user.finished_directions.size / directions_count) * 100
      [
        { label: 'In progress', value: in_progress_directions.to_f, color: '#3366CC' },
        { label: 'New directions', value: new_directions.to_f, color: '#DC3912' },
        { label: 'Finished directions', value: finished_directions.to_f, color: '#FF9900' }
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
        hash = { label: 'Finished', color: '#3366CC' }
      when false
        hash = { label: 'Cancelled', color: '#DC3912' }
      when nil
        hash = { label: 'In progress', color: '#FF9900' }
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
end
