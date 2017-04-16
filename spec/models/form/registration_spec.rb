# frozen_string_literal: true
require 'rails_helper'

describe Form::Registration do
  let!(:auth) do
    {
      provider: 'UProgress',
      platform: 'macOS',
      platform_version: '10.11',
      app_version: '56.14.3'
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

  describe '#submit' do
    context 'with valid attributes' do
      let!(:form) { ::Form::Registration.new(User.new, user_attr) }

      it 'creates new user' do
        expect do
          form.submit
        end.to change(User, :count).by(1)
      end

      it 'creates NotificationSetting for new user' do
        expect do
          form.submit
        end.to change(NotificationSetting, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      let!(:form) { ::Form::Registration.new(User.new, {}) }

      it 'does not creates a new user' do
        expect do
          form.submit
        end.to change(User, :count).by(0)
      end

      it 'does not creates NotificationSetting for new user' do
        expect do
          form.submit
        end.to change(NotificationSetting, :count).by(0)
      end

      context 'error message' do

        before { form.submit }

        %w(email password nick authorization).each do |attr|
          it "error message contain #{attr} key" do
            expect(form.errors.messages).to have_key(attr.to_sym)
          end
        end
      end
    end
  end
end
