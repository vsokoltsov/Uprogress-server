# frozen_string_literal: true
require 'rails_helper'

describe Service::Appointment::Never do
  let!(:user) { create :user }
  let!(:direction) { create :direction, user_id: user.id }

  describe 'send_notification' do
    context 'with valid attributes' do
      let!(:appointment) { create :appointment, direction_id: direction.id }
      let!(:appointment_service) { Service::Appointment::Never.new(appointment) }

      before do
        ::Service::PushNotifications.any_instance.stub(:send_notification)
                                    .with(any_args).and_return(true)
      end

      it 'call send_notification method on user' do
        expect_any_instance_of(
          ::Service::PushNotifications
        ).to receive(:send_notification).with(any_args).and_return(true)

        appointment_service.send_notification
      end

      it 'updates appointment' do
        appointment_service.send_notification
        appointment.reload
        expect(appointment.available).to be_falsy
      end
    end

    context 'with invalid attributes' do
      context 'appointment is not available' do
        let!(:appointment) do
          create :appointment, direction_id: direction.id, available: false
        end
        let!(:appointment_service) { Service::Appointment::EveryDay.new(appointment) }

        it 'send notification does not called' do
          expect_any_instance_of(
            ::Service::PushNotifications
          ).to receive(:send_notification).with(any_args).and_return(false)

          appointment_service.send_notification
        end
      end

      context 'start date is not today' do
        let!(:appointment) do
          create :appointment, direction_id: direction.id, date: Time.zone.now + 1.week
        end
        let!(:appointment_service) { Service::Appointment::EveryDay.new(appointment) }

        it 'send notification does not called' do
          expect_any_instance_of(
            ::Service::PushNotifications
          ).to receive(:send_notification).with(any_args).and_return(false)

          appointment_service.send_notification
        end
      end
    end
  end
end
