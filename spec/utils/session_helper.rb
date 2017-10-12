# frozen_string_literal: true

module SessionHelper
  include JsonWebToken

  def retrieve_access_token(auth)
    generate_token_for_auth(auth)
  end

  def retrieve_super_admin_access_token(user) # This is used for super admin session creation
    generate_token_for_auth(user, true)
  end
end
