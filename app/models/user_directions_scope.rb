# frozen_string_literal: true
class UserDirectionsScope
  attr_accessor :user

  def initialize(user)
    self.user = user
  end
end
