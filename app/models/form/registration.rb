class Form::Registration < Form::Base
  include EmailValidation
  include PasswordValidation
  include AuthorizationConcern
  include JsonWebToken
  attribute :email
  attribute :password
  attribute :password_confirmation
  attribute :nick

  attr_accessor :token, :authorization

  validates :nick, presence: true
  validate :nick_length

  def attributes=(attrs)
    super(attrs)
    @authorization = attrs['authorization']
  end

  def email=(attr)
    super(attr.downcase.strip)
  end

  def nick=(attr)
    nick_value = attr.downcase.strip.gsub(/\.|-/, '_')
    translated = Translit.convert(nick_value, :english)
    super(translated)
  end

  def submit
    begin
      super do
        auth = build_authorizaiton(@authorization, @object)
        @token = generate_token_for_auth(auth)
        true
      end
    rescue ActiveRecord::RecordNotUnique
      binding.pry
    end
  end

  private

  def nick_length
    nick_size = nick.scan(/\w+/).size
    if nick_size > 1
      erros.add(:nick, 'Maximum one word')
      false
    end
  end
end
