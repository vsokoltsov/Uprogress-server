# frozen_string_literal: true
require 'rails_helper'

describe Api::V1::RegistrationsController do
  let!(:auth) do
    {
      platform: 'OS X',
      platform_version: '10.11.3',
      app_name: 'Chrome',
      app_version: '49.0.2623.87',
      provider: 'Estudy'
    }
  end

  let!(:user_attr) do
    {
      email: 'example@mail.com',
      password: '1234567',
      password_confirmation: '1234567',
      nick: 'nick',
      authorization: auth
    }.stringify_keys!
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new user' do
        expect do
          post :create, params: { user: user_attr }
        end.to change(User, :count).by(1)
      end

      it 'return current user token' do
        post :create, params: { user: user_attr }
        token = JSON.parse(response.body)['token']
        expect(Authorization.decode_jwt_and_find(token).user.id).to eq(User.last.id)
      end
    end

    context 'with invalid attributes' do
      it 'doesn\'t create a new user' do
        expect do
          post :create, params: { user: {} }
        end.to change(User, :count).by(0)
      end

      context 'errors' do
        before { post :create, params: { user: {} } }

        %w(email password nick authorization).each do |attr|
          it "contains #{attr} attribute" do
            expect(JSON.parse(response.body)['errors']).to have_key(attr)
          end
        end
      end
    end
  end
end
