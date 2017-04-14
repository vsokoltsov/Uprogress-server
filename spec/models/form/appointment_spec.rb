# frozen_string_literal: true
require 'rails_helper'

describe Form::Appointment do
  let!(:direction) { create :direction }
  let!(:params) do
    {
      direction_id: direction.id,
      message: 'Test',
      date: (Time.zone.now + 1.day).strftime('%Y-%m-%d %H:%M:%S'),
      repeats: 1
    }
  end

  describe '#submit' do
    context 'with valid attributes' do
      let!(:form) { Form::Appointment.new(Appointment.new, params) }

      it 'creates new appointment' do
        expect { form.submit }.to change(Appointment, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      let!(:form) { Form::Appointment.new(Appointment.new, {}) }

      it 'does not create new appointment' do
        expect { form.submit }.to change(Appointment, :count).by(0)
      end

      context 'errors' do
        before { form.submit }

        %w(direction_id repeats date).each do |attr|
          it "contains #{attr} key" do
            expect(form.errors.messages).to have_key(attr.to_sym)
          end
        end
      end
    end
  end
end
