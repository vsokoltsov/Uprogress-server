# frozen_string_literal: true
class StatisticsSerializer < ActiveModel::Serializer
  root 'statistics'
  attributes :directions, :steps

  def directions
    directions_count = object.directions.size.to_f
    if directions_count.positive?
      in_progress_directions = (object.in_progress_directions.size / directions_count) * 100
      new_directions = (object.new_directions.size / directions_count) * 100
      finished_directions = (object.finished_directions.size / directions_count) * 100
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
    steps_list_for_directions = object.directions.map(&:steps).flatten
    steps_list_for_directions.group_by(&:is_done).each do |item|
    end
  end
end
