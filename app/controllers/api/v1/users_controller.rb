# frozen_string_literal: true
class Api::V1::UsersController < Api::ApiController
  def show
    user = User.find(params[:id])
    render json: user, serializer: UserSerializer
  end
end
