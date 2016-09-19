class Form::Registration < Form::Base
  include AuthorizationConcern
  attribute :email
  attribute :password
  attribute :password_confirmation
  attribute :nick

  attr_accessor :token, :authorization

  def attributes=(attrs)
    super(attrs)
    @authorization = attrs['authorization']
  end

  def email=(attr)
    super(attr.downcase.strip)
  end

  def nick=(attr)
    super(attr.downcase.strip)
  end

  def submit
    begin
      super do
        auth = build_authorizaiton(@authorization, @object)
        @token = generate_token_for_auth(auth)
        true
      end
    rescue ActiveRecord::RecordNotUnique
    end
  end
end
