class Form::Direction < Form::Base
  attribute :title
  attribute :description
  attribute :slug

  validates :title, :description, presence: true

  def slug
    Translit.convert(title.underscore.gsub(/\.|-/, '_'), :english)
  end
end
