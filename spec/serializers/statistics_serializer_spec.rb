# frozen_string_literal: true
require 'rails_helper'

describe StatisticsSerializer do
  let!(:user) { create :user }
  let!(:serializer) { StatisticsSerializer.new(user) }
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

    %w(directions steps directions_steps).each do |attr|
      it "contains #{attr}" do
        expect(object).to have_key(attr)
      end
    end

    describe '#directions' do
      context 'directions are empty' do
        it 'return empty array' do
          expect(object['directions']).to match_array []
        end
      end

      context 'directions are present' do
        let!(:direction) { create :direction, user_id: user.id }
        let!(:finished_direction) { create :direction, user_id: user.id }
        let!(:step) { create :step, direction_id: direction.id }
        let!(:finished_step) { create :step, direction_id: finished_direction.id, is_done: true }
        let!(:in_progress_direction) { create :direction, user_id: user.id }
        let!(:in_progress_step) do
          create :step, direction_id: in_progress_direction.id, is_done: false
        end

        before do
          user.reload
          serializer = StatisticsSerializer.new(user)
          serialization = ActiveModelSerializers::Adapter.create(serializer)
          root_key = serializer.json_key
          subject = JSON.parse(serialization.to_json)
          @object = subject[root_key]
        end

        it 'return array with lenth 3' do
          expect(@object['directions'].size).to eq(3)
        end

        ['In progress', 'New directions', 'Finished directions'].each_with_index do |label, index|
          it "object array include hash with label #{label}" do
            expect(@object['directions'][index]['label']).to eq(label)
          end
        end

        %w(#3366CC #DC3912 #FF9900).each_with_index do |color, index|
          it "object array include hash with color #{color}" do
            expect(@object['directions'][index]['color']).to eq(color)
          end
        end
      end
    end

    describe '#steps' do
      context 'directions are empty' do
        it 'return empty array' do
          expect(object['steps']).to match_array []
        end
      end

      context 'steps (and directions) are present' do
        let!(:direction) { create :direction, user_id: user.id }
        let!(:finished_direction) { create :direction, user_id: user.id }
        let!(:step) { create :step, direction_id: direction.id }
        let!(:finished_step) { create :step, direction_id: finished_direction.id, is_done: true }
        let!(:in_progress_direction) { create :direction, user_id: user.id }
        let!(:in_progress_step) do
          create :step, direction_id: in_progress_direction.id, is_done: false
        end

        before do
          user.reload
          serializer = StatisticsSerializer.new(user)
          serialization = ActiveModelSerializers::Adapter.create(serializer)
          root_key = serializer.json_key
          subject = JSON.parse(serialization.to_json)
          @object = subject[root_key]
        end

        it 'return array with lenth 3' do
          expect(@object['directions'].size).to eq(3)
        end

        ['Finished', 'Cancelled', 'In progress'].each_with_index do |label, index|
          it "object array include hash with label #{label}" do
            expect(@object['steps'][index]['label']).to eq(label)
          end
        end

      end
    end

    describe '#direction_steps' do

    end
  end
end
