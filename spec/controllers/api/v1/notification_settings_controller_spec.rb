# frozen_string_literal: true
require 'rails_helper'

describe Api::V1::NotificationSettingsController do
  let!(:auth) { create :authorization }
  let!(:setting) { create :notification_setting, user_id: auth.user.id }

  describe 'GET #index' do
    it 'respond with user notification setting' do
      get_with_token auth, :index, user_id: auth.user.id
      expect(response.status).to eq 200
    end

    context 'success' do
      before { get_with_token auth, :index, user_id: auth.user.id }

      %w(id user_id push_enabled mail_enabled).each do |attr|
        it "success response contains #{attr} attribute" do
          expect(response.body).to be_json_eql(setting.send(attr.to_sym).to_json)
            .at_path("setting/#{attr}")
        end
      end
    end
  end

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
