# frozen_string_literal: true
require 'spec_helper'

describe Service::PushNotifications do
  let!(:authorization) { create :authorization, platform: 'Android' }

  describe '#send_notification' do
    context 'tokens are present' do
      let!(:device) { create :device, authorization_id: authorization.id }
      let!(:push_notifications) { Service::PushNotifications.new(authorization.user) }

      it 'calls push_notification method in Notification::Android' do
        expect_any_instance_of(
          Service::Notification::Android
        ).to receive(:push_notification).and_return(true)
        Service::Notification::Android.any_instance.stub(:push_notification).and_return(true)
        push_notifications.send_notification('Test')
      end
    end

    context 'tokens are not present' do
      let!(:push_notifications) { Service::PushNotifications.new(authorization.user) }

      it 'does not calls push_notification method in Notification::Android' do
        expect_any_instance_of(Service::Notification::Android).not_to receive(:push_notification)
        push_notifications.send_notification('Test')
      end
    end
  end
end
