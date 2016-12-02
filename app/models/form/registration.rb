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

  validates :nick, :authorization, presence: true
  validate :nick_length
  validates_confirmation_of :password, if: lambda { |m| m.password.present? }

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
    rescue ActiveRecord::RecordNotUnique => e
      %w(email nick).each do |attr|
        errors.add(attr.to_sym, " #{attr} already taken") if e.message.match /Key \(#{attr}\)/
      end
      false
    end
  end

  private

  def nick_length
    nick_size = nick&.scan(/\w+/)&.size
    if nick_size.present? && nick_size > 1
      erros.add(:nick, 'Maximum one word')
      false
    end
  end
end
