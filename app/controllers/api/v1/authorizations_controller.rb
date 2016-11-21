# frozen_string_literal: true
class Api::V1::AuthorizationsController < Api::ApiController
  before_action :validate_token

  def index
    authorizations = current_user.authorizations
    render json: { authorizations: authorizations }
  end

  def destroy
  end
end
