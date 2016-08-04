class Form::Step < Form::Base
  attribute :title
  attribute :is_done
  attribute :description

  validates :title, :description, presence: true
end
