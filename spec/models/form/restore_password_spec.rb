# frozen_string_literal: true

require 'rails_helper'

describe Form::RestorePassword do
  describe '#restore' do
    context('with valid attributes') do
      let!(:user) { create :user }
      let!(:form) { ::Form::RestorePassword.new(nil, email: user.email) }

      it 'sends notification' do
        form.restore
        expect(
          UserMailer.method(:restore_password)
        ).to be_delayed(user, retrieve_access_token(user))
      end

      it 'updates user reset_password_token field' do
        form.restore
        user.reload
        expect(user.reset_password_token).not_to be_nil
      end

      it 'creates token' do
        form.restore
        expect(
          User.find(JWT.decode(form.token, nil, false).first['id'])
        ).to eq user
      end
    end

    context('with invalid attributes') do
      let!(:form) { ::Form::RestorePassword.new(nil, email: '') }

      it 'add errors to for object' do
        form.restore
        expect(form.errors).to have_key(:email)
      end
    end
  end
end
