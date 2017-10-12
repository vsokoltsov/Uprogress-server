# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::DevicesController do
  let!(:auth) { create :authorization }
  let!(:device) { create :device, authorization_id: auth.id }

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'receives success response' do
        post_with_token auth, :create, device: { token: '12345' }
        expect(response.status).to eq 200
      end
    end

    context 'with invalid attributes' do
      it 'receives failed response' do
        post_with_token auth, :create, device: {}
        expect(response.status).to eq 422
      end
    end
  end
end
