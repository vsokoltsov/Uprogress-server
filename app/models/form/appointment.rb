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
    if date.present?
      now = Time.zone.now
      local = now.getlocal(date.to_datetime.zone)
      if local >= date.to_datetime
        errors.add(:date, 'Cannot be in the past')
      end
    end
  end
end
