# frozen_string_literal: true
require 'rails_helper'

describe Service::NotificationTransmitter do
  let!(:user) { create :user }
  let!(:direction) { create :direction, user_id: user.id }

  context 'available appointments' do
    let!(:appointment1) { create :appointment, direction_id: direction.id }
    let!(:appointment2) do
      create :appointment, direction_id: direction.id, available: false
    end
    let!(:transmitter) { Service::NotificationTransmitter.new }

    it 'receives #send_notification for Service::Appointment class' do
      expect_any_instance_of(
        Service::Appointment::Never
      ).to receive(:send_notification).exactly(1).times
      Service::Appointment::Never.any_instance.stub(:send_notification).and_return(true)
      transmitter.send_appointments
    end
  end

  context 'appointments at the same time' do

  end
end
