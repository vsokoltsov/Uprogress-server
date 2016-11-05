# frozen_string_literal: true
class Direction < ActiveRecord::Base
  extend FriendlyId
  belongs_to :user
  has_many :steps

  friendly_id :slug, use: :finders

  def percents_result
    steps_list = steps.to_a
    completed_steps = steps.select(&:is_done)
    (completed_steps.size / steps_list.size.to_f * 100).to_i if steps_list.present?
  end
end
