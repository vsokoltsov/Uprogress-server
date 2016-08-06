# frozen_string_literal: true
class Step < ActiveRecord::Base
  belongs_to :direction

  scope :active, -> { where(is_done: false) }
  scope :completed, -> { where(is_done: true) }
end
