# frozen_string_literal: true
require 'rails_helper'

describe Api::V1::NotificationSettingsController do
  let!(:auth) { create :authorization }
  let!(:setting) { create :notification_setting, user_id: auth.user.id }

  describe 'PUT #update' do
    context 'with valid attributes' do
      let!(:attrs) do
        {
          push_enabled: false,
          mail_enabled: true
        }
      end
      it 'updates setting' do
        put_with_token auth, :update, user_id: auth.user.id, id: setting.id,
                                      setting: attrs

        expect(response.status).to eq 200
      end
    end

    context 'with invalid attributes' do
      it 'does not updates setting' do
        put_with_token auth, :update, user_id: auth.user.id, id: setting.id,
                                      setting: {}

        expect(
          JSON.parse(response.body)['notification_setting']['push_enabled']
        ).to eq true
      end
    end
  end
end
