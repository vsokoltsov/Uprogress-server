# frozen_string_literal: true
require 'rails_helper'

describe Direction do
  let!(:user) { create :user }
  let!(:direction) { create :direction, user_id: user.id }
  let!(:step) { create :step, direction_id: direction.id }
  let!(:step_1) { create :step, direction_id: direction.id }

  describe '#percents_result' do
    context 'done steps present' do
      let!(:step_2) { create :step, direction_id: direction.id, is_done: true }

      it 'return 33' do
        expect(direction.percents_result).to eq 33
      end
    end

    context 'done steps are not present' do
      it 'return 0' do
        expect(direction.percents_result).to eq 0
      end
    end
  end
end
