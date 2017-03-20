# frozen_string_literal: true
require 'rails_helper'

describe Form::ResetPassword do
  context('with valid attributes') do
    let!(:user) { create :user }
    let!(:token) { retrieve_access_token(user) }

    context 'user is absent' do
      before { user.update(reset_password_token: token) }

      let!(:form) do
        ::Form::ResetPassword.new(nil, password: 'password',
                                       password_confirmation: 'password',
                                       token: token)
      end

      it 'set reset_password_token to nil' do
        form.reset
        user.reload
        expect(user.reset_password_token).to eq(nil)
      end
    end

    context 'user is present' do
      let!(:form) do
        ::Form::ResetPassword.new(user, password: 'password',
                                        password_confirmation: 'password')
      end

      it 'updates password for current user' do
        expect(form.reset).to be_truthy
      end
    end
  end

  context('with invalid attributes') do
    context 'password is empty' do
      let!(:user) { create :user }
      let!(:token) { retrieve_access_token(user) }
      let!(:form) do
        ::Form::ResetPassword.new(nil, password: '',
                                       password_confirmation: 'example12345',
                                       token: token)
      end

      it 'return error message with password key' do
        form.reset
        expect(form.errors.messages).to have_key(:password)
      end
    end

    context 'token expired' do
      let!(:user) { create :user }
      let!(:token) { retrieve_access_token(user) }
      let!(:form) do
        ::Form::ResetPassword.new(nil, password: 'example12345',
                                       password_confirmation: 'example12345',
                                       token: token)
      end

      it 'return error message with token key' do
        form.reset
        expect(form.errors.messages).to have_key(:token)
      end
    end

    context 'new password equal previous one' do
      let!(:user) { create :user }
      let!(:token) { retrieve_access_token(user) }
      before { user.update(reset_password_token: token) }
      let!(:form) do
        ::Form::ResetPassword.new(nil, password: 'example12345',
                                       password_confirmation: 'example12345',
                                       token: token)
      end

      it 'return error message with password key' do
        form.reset
        expect(form.errors.messages).to have_key(:password)
      end
    end

    context 'token is not valid' do
      let!(:user) { create :user }
      let!(:token) { retrieve_access_token(user) }
      before { user.update(reset_password_token: token) }
      let!(:form) do
        ::Form::ResetPassword.new(nil, password: 'password',
                                       password_confirmation: 'password',
                                       token: '12345')
      end

      it 'return token error' do
        form.reset
        expect(form.errors.messages).to have_key(:token)
      end
    end

    context 'user and token are empty' do
      let!(:form) do
        ::Form::ResetPassword.new(nil, password: 'password',
                                       password_confirmation: 'password')
      end

      it 'return user error' do
        form.reset
        expect(form.errors.messages).to have_key(:user)
      end
    end
  end
end
