# frozen_string_literal: true

require 'rails_helper'

describe StepDirectionSerializer do
  let!(:user) { create :user }
  let!(:direction) { create :direction, user_id: user.id }
  let!(:step) { create :step, direction_id: direction.id }
  let!(:serializer) { StepDirectionSerializer.new(direction) }
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

    %w[id title description percents_result].each do |attr|
      it "contains #{attr}" do
        expect(object).to have_key(attr)
      end

      it "serializer #{attr} value equal to object #{attr} value" do
        expect(object[attr]).to eq(direction.send(attr.to_sym))
      end
    end
  end

  describe 'relations' do
    let!(:object) { subject[root_key] }

    describe 'has_many :steps' do
      it 'has steps relation key' do
        expect(object).to have_key('steps')
      end

      context 'steps attributes' do
        %w[id title description is_done direction_id].each do |attr|
          it "contains #{attr} attribute" do
            expect(object['steps'].first).to have_key(attr)
          end

          it "#{attr} equal to step #{attr} value" do
            expect(object['steps'].first[attr]).to eq(step.send(attr.to_sym))
          end
        end
      end
    end

    describe 'has_one :user' do
      it 'has user relation key' do
        expect(object).to have_key('user')
      end

      context 'user attributes' do
        %w[id first_name last_name location description nick].each do |attr|
          it "contains #{attr} attribute" do
            expect(object['user']).to have_key(attr)
          end

          it "#{attr} equal to step #{attr} value" do
            expect(object['user'][attr]).to eq(user.send(attr.to_sym))
          end
        end
      end
    end
  end
end
