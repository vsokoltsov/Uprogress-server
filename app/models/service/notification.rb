# frozen_string_literal: true
class Notification
  attr_accessor :user

  def initialize(user)
    @user = user
  end
end
