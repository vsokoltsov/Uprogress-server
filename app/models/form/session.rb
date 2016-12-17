class Form::Session < Form::Base

  extend Memoist

  include PasswordValidation
  include EmailValidation
  include JsonWebToken
  include AuthorizationConcern

  attr_accessor :token, :user
  attribute :email
  attribute :password
  attribute :authorization

  validates :authorization, presence: true

  memoize :user

  def submit
    return unless valid?
    authorization!
  end

  private

  def authorization!
    if user && user.authenticate(password)
      auth = build_authorizaiton(authorization, user)
      self.token = generate_token_for_auth(auth)
    else
      errors.add(:email, "User doesn't exist")
      false
    end
  end

  def user
    ::User.find_by(email: email)
  end
end
