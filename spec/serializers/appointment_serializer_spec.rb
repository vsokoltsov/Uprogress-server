# frozen_string_literal: true
require 'rails_helper'

describe AppointmentSerializer do
  let!(:auth) { create :authorization }
  let!(:direction) { create :direction, user_id: auth.user.id }
  let!(:appointment) { create :appointment, direction_id: direction.id }

  let!(:serializer) { AppointmentSerializer.new(appointment) }
  let!(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }
  let(:root_key) { serializer.json_key }
  subject { JSON.parse(serialization.to_json) }

  describe 'root key' do
    it 'has a root key' do
      expect(subject).to have_key(root_key)
    end
  end

  describe 'attributes' do
    let!(:object) { subject[root_key] }

    %w(id message).each do |attr|
      it "contains #{attr}" do
        expect(object).to have_key(attr)
      end
    end
  end

  describe 'relations' do
    let!(:object) { subject[root_key] }

    describe 'has_one :direction' do
      it 'has direction relation key' do
        expect(object).to have_key('direction')
      end

      context 'direction attributes' do
        %w(id title description percents_result finished_steps_count slug).each do |attr|
          it "contains #{attr}" do
            expect(object['direction']).to have_key(attr)
          end

          it "serializer #{attr} value equal to object #{attr} value" do
            expect(object[attr]).to eq(direction.send(attr.to_sym))
          end
        end
      end
    end
  end
end
