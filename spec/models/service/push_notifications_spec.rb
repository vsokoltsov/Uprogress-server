# frozen_string_literal: true
require 'spec_helper'

describe Service::PushNotifications do
  let!(:authorization) { create :authorization, platform: 'Android' }
  let!(:ios_authorization) { create :authorization, platform: 'iOS', user: authorization.user }

  describe '#send_notification' do
    context 'tokens are present' do
      let!(:android_device) { create :device, authorization_id: authorization.id }
      let!(:ios_device) { create :device, authorization_id: ios_authorization.id }
      let!(:push_notifications) { Service::PushNotifications.new(authorization.user) }

      it 'calls push_notification method in Notification::Android' do
        expect_any_instance_of(
          Service::Notification::Android
        ).to receive(:push_notification).and_return(true)
        expect_any_instance_of(
          Service::Notification::Ios
        ).to receive(:push_notification).and_return(true)
        Service::Notification::Android.any_instance.stub(:push_notification).and_return(true)
        Service::Notification::Ios.any_instance.stub(:push_notification).and_return(true)
        push_notifications.send_notification('Test')
      end
    end

    context 'tokens are not present' do
      let!(:push_notifications) { Service::PushNotifications.new(authorization.user) }

      it 'does not calls push_notification method in Notification::Android' do
        expect_any_instance_of(Service::Notification::Android).not_to receive(:push_notification)
        expect_any_instance_of(Service::Notification::Ios).not_to receive(:push_notification)
        push_notifications.send_notification('Test')
      end
    end
  end
end
