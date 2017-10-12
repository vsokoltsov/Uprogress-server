# frozen_string_literal: true

class Direction < ApplicationRecord
  extend FriendlyId
  belongs_to :user
  has_many :steps, dependent: :destroy
  has_many :appointments, dependent: :destroy

  friendly_id :slug, use: :finders

  def percents_result
    steps_list = steps.to_a
    completed_steps = steps.select(&:is_done)
    (completed_steps.size / steps_list.size.to_f * 100).to_i if steps_list.present?
  end
end
