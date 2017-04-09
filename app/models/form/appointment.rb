class Form::Appointment < Form::Base
  attribute :direction_id
  attribute :date
  attribute :repeats
  attribute :message

  validates :direction_id, :date, :repeats, presence: true
  validate :past_time?

  def submit
    super "#{direction_id}_appointment"
  end

  private

  def past_time?
    binding.pry
    if Time.zone.now >= date.to_datetime
      errors.add(:date, 'Cannot be in the past')
    end
  end
end
