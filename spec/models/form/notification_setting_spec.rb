# frozen_string_literal: true

require 'rails_helper'

describe Form::NotificationSetting do
  let!(:user) { create :user }
  let!(:notification) { create :notification_setting, user_id: user.id }

  context 'with valid attributes' do
    let!(:attrs) do
      {
        push_enabled: false,
        mail_enabled: true
      }
    end
    let!(:form) { Form::NotificationSetting.new(notification, attrs) }

    it 'updates value of user notification' do
      form.submit
      notification.reload
      expect(notification.push_enabled).to be_falsy
    end
  end

  context 'with invalid attributes' do
    let!(:form) { Form::NotificationSetting.new(notification, {}) }

    it 'does not updates the notification setting' do
      form.submit
      notification.reload
      expect(notification.push_enabled).to eq notification.push_enabled
    end
  end
end
