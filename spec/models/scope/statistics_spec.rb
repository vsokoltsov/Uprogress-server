require 'rails_helper'

# frozen_string_literal: true
require 'rails_helper'

describe Scope::Statistics do
  let!(:user) { create :user }
  let!(:user_direction_scope) { Scope::Statistics.new(user) }

  describe '#directions' do
    subject { user_direction_scope.directions }

    context 'directions are empty' do
      it 'return empty array' do
        expect(subject).to match_array []
      end
    end

    context 'directions are present' do

      before do
        create_objects!
        user.reload
      end

      it 'return array with lenth 3' do
        expect(subject.size).to eq(3)
      end

      ['In progress', 'New directions', 'Finished directions'].each_with_index do |label, index|
        it "object array include hash with label #{label}" do
          expect(subject[index][:label]).to eq(label)
        end
      end

      %w[#3366CC #DC3912 #FF9900].each_with_index do |color, index|
        it "object array include hash with color #{color}" do
          expect(subject[index][:color]).to eq(color)
        end
      end
    end
  end

  describe '#steps' do
    subject { user_direction_scope.steps }

    context 'directions are empty' do
      it 'return empty array' do
        expect(subject).to match_array []
      end
    end

    context 'steps (and directions) are present' do
      before do
        create_objects!
        user.reload
      end

      it 'return array with lenth 3' do
        expect(subject.size).to eq(3)
      end

      ['Finished', 'Cancelled', 'In progress'].each do |label|
        it "object array include hash with label #{label}" do
          expect(subject.map { |x| x[:label] }).to include(label)
        end
      end

    end
  end

  describe '#direction_steps' do
    subject { user_direction_scope.directions_steps }

    context 'directions are empty' do
      it 'return empty array' do
        expect(subject).to match_array []
      end
    end

    context 'directions are not empty' do
      before do
        create_objects!
        user.reload
        @directions = subject.map { |x| x[:label] }
      end

      it 'return array with lenth 3' do
        expect(subject.size).to eq(3)
      end

      it 'contains the direction title' do
        expect(@directions).to include(@direction.title)
      end

      it 'contains the finished direction title' do
        expect(@directions).to include(@finished_direction.title)
      end

      it 'contains the in progress direction title' do
        expect(@directions).to include(@in_progress_direction.title)
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
