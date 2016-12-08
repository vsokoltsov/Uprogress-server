# frozen_string_literal: true
require 'rails_helper'

describe Api::V1::SessionsController do
  let!(:user) { create :user }
  let!(:auth) do
    {
      platform: 'OS X',
      platform_version: '10.11.3',
      app_name: 'Chrome',
      app_version: '49.0.2623.87',
      provider: 'Estudy'
    }
  end
  let!(:authorization) { create :authorization }

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'create new token for user' do
        post :create, params: { user: { email: user.email,
                                        password: user.password,
                                        authorization: auth } }
        token = JSON.parse(response.body)['token']
        expect(Authorization.decode_jwt_and_find(token).user).to eq(user)
      end
    end

    context 'with invalid attributes' do
      before { post :create, params: { user: {} } }

      context 'error messages' do
        %w(email password authorization).each do |attr|
          it "contains #{attr} key" do
            expect(JSON.parse(response.body)['errors']).to have_key(attr)
          end
        end
      end
    end
  end

  describe 'GET #current' do
    it 'receives current user' do
      get_with_token authorization, :current
      expect(JSON.parse(response.body)['current_user']['id']).to eq(authorization.user.id)
    end
  end
end
