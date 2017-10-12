# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::UsersController do
  let!(:auth) { create :authorization }
  let!(:user_attrs) do
    {
      email: 'example@mail.com',
      first_name: 'Ololo',
      last_name: 'Oloshevich'
    }
  end

  describe 'GET #show' do
    before { get :show, params: { id: auth.user.nick } }

    context 'success response' do
      %w[id first_name last_name location
         nick description attachment directions
         finished_directions new_directions].each do |attr|
           it "contains #{attr} attribute" do
             expect(response.body).to be_json_eql(auth.user.send(attr.to_sym).to_json)
               .at_path("user/#{attr}")
           end
         end
    end
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      before do
        put_with_token auth, :update, id: auth.user.id, user: user_attrs
        auth.user.reload
      end

      it 'update user information' do
        expect(auth.user.first_name).to eq(user_attrs[:first_name])
      end

      context 'success response' do
        %w[id first_name last_name location
           nick description attachment].each do |attr|
             it "contains #{attr} attribute" do
               expect(response.body).to be_json_eql(auth.user.send(attr.to_sym).to_json)
                 .at_path("current_user/#{attr}")
             end
           end
      end
    end

    context 'with invalid attributes' do
      before do
        put_with_token auth, :update, id: auth.user.id, user: {}
        auth.user.reload
      end

      it 'doesn\'t update user information' do
        expect(auth.user.first_name).to eq(auth.user.first_name)
      end

      context 'errors' do
        %w[first_name last_name].each do |attr|
          it "contains #{attr} key" do
            expect(JSON.parse(response.body)['errors']).to have_key(attr)
          end
        end
      end
    end
  end

  describe 'GET #statistics' do
    before { get :statistics, params: { id: auth.user.id } }

    context 'success response' do
      %w[directions steps directions_steps].each do |attr|
        it "contains #{attr} attribute" do
          expect(JSON.parse(response.body)['statistics']).to have_key(attr)
        end
      end
    end
  end

  describe 'PUT #reset_password' do

    context 'with valid attributes' do
      before do
        put_with_token auth, :change_password, user: {
          password: 'password123',
          password_confirmation: 'password123'
        }
      end

      %w[id first_name last_name location
         nick description attachment].each do |attr|
           it "contains #{attr} attribute" do
             expect(response.body).to be_json_eql(auth.user.send(attr.to_sym).to_json)
               .at_path("current_user/#{attr}")
           end
         end
    end

    context 'with invalid attributes' do
      before do
        put_with_token auth, :change_password, user: {
          password: '',
          password_confirmation: ''
        }
      end

      context 'errors' do
        %w[password].each do |attr|
          it "contains #{attr} key" do
            expect(JSON.parse(response.body)['errors']).to have_key(attr)
          end
        end
      end
    end
  end
end
