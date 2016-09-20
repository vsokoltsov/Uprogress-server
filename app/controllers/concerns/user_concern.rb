# frozen_string_literal: true
module UserConcern
  def find_user
    @user = User.find(params[:user_id])
  end
end
