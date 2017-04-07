class Form::Appointment < Form::Base
  attribute :direction_id
  attribute :date
  attribute :repeats
  attribute :message

  validates :direction_id, :date, :repeats, presence: true

  def submit
    super "#{direction_id}_appointment"
  end
end