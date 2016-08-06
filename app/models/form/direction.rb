class Form::Direction < Form::Base
  attribute :title
  attribute :description

  validates :title, :description, presence: true
end
