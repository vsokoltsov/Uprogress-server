# frozen_string_literal: true
class User < ActiveRecord::Base
  extend FriendlyId

  has_many :authorization
  has_many :directions
  has_one :attachment, as: :attachable, dependent: :destroy
  has_many :system_logs

  has_secure_password

  friendly_id :nick, use: :finders

  def finished_directions
    directions.select do |attr|
      steps_status = attr.steps.map(&:is_done)
      steps_status.uniq.length == 1 && steps_status.first
    end
  end

  def new_directions
    directions.select do |attr|
      attr.steps.blank?
    end
  end

  def in_progress_directions
    directions.select do |item|
      steps_status = item.steps.map(&:is_done)
      steps_status.uniq.size > 1 || !steps_status.first.nil?
    end
  end
end
