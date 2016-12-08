# frozen_string_literal: true
require 'rails_helper'

describe Form::Session do
  let!(:auth) do
    {
      provider: 'UProgress',
      platform: 'macOS',
      platform_version: '10.11',
      app_version: '56.14.3'
    }
  end
  let!(:user) { create :user }

  describe '#submit' do
    let!(:user_attrs) do
      { email: user.email, password: user.password, authorization: auth }
    end
    let!(:form) { ::Form::Session.new(nil, user_attrs) }

    context 'with valid attributes' do
      it 'return authentication token' do
        form.submit
        expect(Authorization.decode_jwt_and_find(form.token).user).to eq(user)
      end
    end

    context 'with invalid attributes' do
      let!(:form) { ::Form::Session.new(nil, {}) }

      context 'errors' do
        before { form.submit }

        %w(email password authorization).each do |attr|
          it "error message contains #{attr} key" do
            expect(form.errors.messages).to have_key(attr.to_sym)
          end
        end
      end
    end
  end
end
