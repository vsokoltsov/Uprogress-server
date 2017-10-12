# frozen_string_literal: true

require 'rails_helper'

describe Form::Device do
  let!(:auth) { create :authorization }
  let!(:device) { create :device, authorization_id: auth.id }

  context 'with valid attributes' do
    let!(:attrs) do
      {
        authorization_id: auth.id,
        token: '12345'
      }
    end
    let!(:form) { Form::Device.new(attrs) }

    before { form.submit }

    it 'update authorizations device value' do
      expect(auth.device.id).to eq(Device.last.id)
    end

    it 'deletes previous device if present' do
      expect { device.reload }.to raise_error ActiveRecord::RecordNotFound
    end
  end

  context 'with invalid attributes' do
    let!(:form) { Form::Device.new({}) }

    before { form.submit }

    it 'does update authorization\'s device' do
      expect(auth.device.id).to eq(device.id)
    end

    context 'errors' do
      %w[token authorization_id].each do |attr|
        it "form error contains #{attr}" do
          expect(form.errors.messages).to have_key(attr.to_sym)
        end
      end
    end
  end
end
