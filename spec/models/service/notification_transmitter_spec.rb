# frozen_string_literal: true
require 'rails_helper'

describe Service::NotificationTransmitter do
  let!(:user) { create :user }
  let!(:direction) { create :direction, user_id: user.id }

end
