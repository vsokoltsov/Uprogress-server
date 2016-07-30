class Form::Step < Form::Base
  attribute :title
  attribute :is_done
  attribute :result

  validates :title, presence: true
end
