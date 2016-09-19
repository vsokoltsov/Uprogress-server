class Form::Session < Form::Base
  include PasswordValidation
  include EmailValidation
  include JsonWebToken
  include AuthorizationConcern

  attr_accessor :token
  attribute :email
  attribute :password
  attribute :authorization

  validates :authorization, presence: true

  def submit
    return unless valid?
    @user = ::User.find_by(email: email) if email.present?
    authorization!
  end

  private

  def authorization!
    if @user && @user.authenticate(password)
      auth = build_authorizaiton(authorization, @user)
      @token = generate_token_for_auth(auth)
    else
      errors.add(:email, I18n.t('user.errors.user_doesnt_exist'))
      false
    end
  end
end
