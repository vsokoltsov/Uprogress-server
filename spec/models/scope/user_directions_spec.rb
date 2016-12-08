# frozen_string_literal: true
require 'rails_helper'

describe Scope::UserDirections do
  let!(:user) { create :user }
  let!(:directions_scope) { Scope::UserDirections.new(user) }

  context 'queries' do

    describe '#finished_directions' do
      let(:object) { directions_scope.finished_directions }

      context 'directions are empty' do
        it 'returns empty array' do
          expect(object).to match_array []
        end
      end

      context 'directions are not empty' do
        before do
          create_objects!
          user.reload
        end

        it 'return array with finished directions' do
          expect(object.size).to eq(1)
        end

        it 'match finished direction' do
          expect(object.first[:id]).to eq(@finished_direction.id)
        end
      end
    end

    describe '#new_directions' do
      let(:object) { directions_scope.new_directions }

      context 'directions are empty' do
        it 'returns empty array' do
          expect(object).to match_array []
        end
      end

      context 'directions are not empty' do
        before do
          create_objects!
          user.reload
        end

        it 'return array with new directions' do
          expect(object.length).to eq(3)
        end
      end
    end

    describe '#directions' do
      let(:object) { directions_scope.directions }

      context 'directions are empty' do
        it 'returns empty array' do
          expect(object).to match_array []
        end
      end

      context 'directions are not empty' do
        before do
          create_objects!
        end

        it 'return array withdirections' do
          expect(object.length).to eq(3)
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
