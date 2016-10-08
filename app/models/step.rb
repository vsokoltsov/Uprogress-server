# frozen_string_literal: true
class Step < ActiveRecord::Base
  belongs_to :direction, dependent: :destroy

  scope :active, -> { where(is_done: false) }
  scope :completed, -> { where(is_done: true) }
end
