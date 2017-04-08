# frozen_string_literal: true
require 'rails_helper'

describe Service::Appointment::Never do
  let!(:user) { create :user }
  let!(:direction) { create :direction, user_id: user.id }
  let!(:appointment) { create :appointment, direction_id: direction.id }
  let!(:appointment_service) { Service::Appointment::Never.new(appointment) }

  describe 'send_notification' do
    context 'with valid attributes' do
      it 'call send_notificatio method on user' do
        expect_any_instance_of(
          ::Service::PushNotifications
        ).to receive(:send_notification).with(any_args).and_return(true)
        ::Service::PushNotifications.any_instance.stub(:send_notification)
                                    .with(any_args).and_return(true)
        appointment_service.send_notification
      end
    end

    context 'with invalid attributes' do

    end
  end
end
