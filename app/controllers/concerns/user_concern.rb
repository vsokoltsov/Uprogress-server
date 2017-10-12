# frozen_string_literal: true

module UserConcern
  def find_user
    @user = User.friendly.find(params[:user_id])
  end
end
