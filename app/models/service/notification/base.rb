# frozen_string_literal: true
class Service::Notification::Base
  attr_accessor :user

  def initialize(user)
    @user = user
  end
end
