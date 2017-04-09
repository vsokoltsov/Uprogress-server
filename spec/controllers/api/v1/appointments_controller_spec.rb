# frozen_string_literal: true
require 'rails_helper'

describe Api::V1::AppointmentsController do
  let!(:auth) { create :authorization }
  let!(:direction) { create :direction }
  let!(:attributes) do
    {
      direction_id: direction.id,
      message: 'Test',
      date: '2017-04-06 12:00:00',
      repeats: 'never'
    }
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates new appointment' do
        expect do
          post_with_token auth, :create, appointment: attributes
        end.to change(Appointment, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new appointment' do
        expect do
          post_with_token auth, :create, appointment: {}
        end.to change(Appointment, :count).by(0)
      end
    end
  end
end
