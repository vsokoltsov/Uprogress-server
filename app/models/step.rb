# frozen_string_literal: true
class Step < ActiveRecord::Base
  belongs_to :direction, counter_cache: true

  scope :active, -> { where(is_done: false) }
  scope :completed, -> { where(is_done: true) }
end
