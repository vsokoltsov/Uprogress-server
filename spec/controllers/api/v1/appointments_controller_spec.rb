# frozen_string_literal: true
require 'rails_helper'

describe Api::V1::AppointmentsController do
  let!(:auth) { create :authorization }
  let!(:direction) { create :direction }
  let!(:appointment) { create :appointment, direction_id: direction.id }
  let!(:attributes) do
    {
      direction_id: direction.id,
      message: 'Test',
      date: (Time.zone.now + 1.day).strftime('%Y-%m-%d %H:%M:%S'),
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

  describe 'PUT #update' do
    let!(:attrs) do
      hash = appointment.attributes
      hash['message'] = 'AAA'
      hash
    end

    context 'with valid attributes' do
      it 'updates appointment' do
        put_with_token auth, :update, id: appointment.id, appointment: attrs
        appointment.reload
        expect(appointment.message).to eq 'AAA'
      end
    end

    context 'with invalid attributes' do
      it 'does not update appointment' do
        put_with_token auth, :update, id: appointment.id, appointment: {}
        appointment.reload
        expect(appointment.message).to eq appointment.message
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes appointment' do
      expect do
        delete_with_token auth, :destroy, id: appointment.id
      end.to change(Appointment, :count).by(-1)
    end
  end
end
