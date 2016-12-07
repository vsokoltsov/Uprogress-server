# frozen_string_literal: true
require 'rails_helper'

describe UserSerializer do
  let!(:user) { create :user }
  let!(:serializer) { UserSerializer.new(user) }
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

    %w(id nick first_name last_name description location
       finished_directions new_directions recent_actions).each do |attr|
      it "contains #{attr}" do
        expect(object).to have_key(attr)
      end
    end
  end

  context 'queries' do
    let!(:object) { subject[root_key] }

    describe '#finished_directions' do
      context 'directions are empty' do
        it 'returns empty array' do
          expect(object['finished_directions']).to match_array []
        end
      end

      context 'directions are not empty' do
        before do
          create_objects!
          serializer = UserSerializer.new(user)
          serialization = ActiveModelSerializers::Adapter.create(serializer)
          @object = JSON.parse(serialization.to_json)[root_key]
        end

        it 'return array with finished directions' do
          expect(@object['finished_directions'].size).to eq(1)
        end

        it 'match finished direction' do
          expect(@object['finished_directions'].first['id']).to eq(@finished_direction.id)
        end
      end
    end

    describe '#new_directions' do
      context 'directions are empty' do
        it 'returns empty array' do
          expect(object['new_directions']).to match_array []
        end
      end

      context 'directions are not empty' do
        before do
          create_objects!
          serializer = UserSerializer.new(user)
          serialization = ActiveModelSerializers::Adapter.create(serializer)
          @object = JSON.parse(serialization.to_json)[root_key]
        end

        it 'return array with new directions' do
          expect(@object['new_directions'].size).to eq(3)
        end
      end
    end

    describe '#directions' do
      context 'directions are empty' do
        it 'returns empty array' do
          expect(object['directions']).to match_array []
        end
      end

      context 'directions are not empty' do
        before do
          create_objects!
          serializer = UserSerializer.new(user)
          serialization = ActiveModelSerializers::Adapter.create(serializer)
          @object = JSON.parse(serialization.to_json)[root_key]
        end

        it 'return array withdirections' do
          expect(@object['directions'].size).to eq(3)
        end
      end
    end
  end
end

def create_objects!
  @direction = create :direction, user_id: user.id
  @finished_direction = create :direction, user_id: user.id
  @in_progress_direction = create :direction, user_id: user.id
  create :step, direction_id: @finished_direction.id, is_done: true
  create :step, direction_id: @in_progress_direction.id, is_done: false
  create :step, direction_id: @direction.id, is_done: nil
end
