# frozen_string_literal: true

require 'rails_helper'

describe StepSerializer do
  let!(:user) { create :user }
  let!(:direction) { create :direction, user_id: user.id }
  let!(:step) { create :step, direction_id: direction.id }
  let!(:serializer) { StepSerializer.new(step) }
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

    %w[id title description is_done direction_id].each do |attr|
      it "contains #{attr}" do
        expect(object).to have_key(attr)
      end

      it "serializer #{attr} value equal to object #{attr} value" do
        expect(object[attr]).to eq(step.send(attr.to_sym))
      end
    end
  end

  describe 'relations' do
    let!(:object) { subject[root_key] }

    describe 'belongs_to :direction' do
      it 'has direction relation key' do
        expect(object).to have_key('direction')
      end

      context 'direction attributes' do
        %w[id title description
           percents_result finished_steps_count].each do |attr|
          it "contains #{attr} key" do
            expect(object['direction']).to have_key(attr)
          end

          it "#{attr} equal to direction #{attr} value" do
            expect(object['direction'][attr]).to eq(direction.send(attr.to_sym))
          end
        end
      end
    end
  end

end
