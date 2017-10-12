# frozen_string_literal: true

require 'rails_helper'

describe Form::User do
  let!(:user) { create :user }
  let!(:user_attrs) do
    {
      email: 'example@mail.com',
      first_name: 'Ololo',
      last_name: 'Oloshevich'
    }
  end

  describe '#submit' do
    context 'with valid attributes' do
      let!(:form) { ::Form::User.new(user, user_attrs) }

      it 'update user name' do
        form.submit
        user.reload
        expect(user.first_name).to eq(user_attrs[:first_name])
        expect(user.last_name).to eq(user_attrs[:last_name])
      end
    end

    context 'with invalid attributes' do
      let!(:form) { ::Form::User.new(user, {}) }

      it 'doesn\'t update user name' do
        form.submit
        user.reload
        expect(user.first_name).to eq(nil)
        expect(user.last_name).to eq(nil)
      end
    end
  end
end
