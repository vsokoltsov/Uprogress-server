# frozen_string_literal: true

require 'rails_helper'

describe Scope::User do
  let!(:user) { create :user }
  let!(:direction) { create :direction, user_id: user.id }
  let!(:step) { create :step, direction_id: direction.id }
  let!(:scope_object) { Scope::User.new(user) }

  describe '#finished_directions' do
    let!(:direction_f) { create :direction, user_id: user.id }
    let!(:step_f) { create :step, direction_id: direction_f.id, is_done: true }

    it 'return array with length 1' do
      expect(scope_object.finished_directions.length).to eq 1
    end

    it 'equal to finished direction' do
      expect(scope_object.finished_directions).to match_array [direction_f]
    end
  end

  describe '#new_directions' do
    let!(:direction_n) { create :direction, user_id: user.id }

    it 'return array with length 1' do
      expect(scope_object.new_directions.length).to eq 1
    end

    it 'equal to finished direction' do
      expect(scope_object.new_directions).to match_array [direction_n]
    end
  end

  describe '#in_progress_directions' do
    let!(:direction_p) { create :direction, user_id: user.id }
    let!(:step_p) { create :step, direction_id: direction_p.id, is_done: false }

    it 'return array with length 1' do
      expect(scope_object.in_progress_directions.length).to eq 2
    end

    it 'equal to finished direction' do
      expect(scope_object.in_progress_directions).to match_array [direction, direction_p]
    end
  end
end
