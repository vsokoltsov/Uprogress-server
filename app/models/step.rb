class Step < ActiveRecord::Base
  belongs_to :directions

  scope :active, -> { where(is_done: false) }
  scope :completed, -> { where(is_done: true) }
end
