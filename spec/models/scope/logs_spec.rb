# frozen_string_literal: true

require 'rails_helper'

describe Scope::Logs do
  let!(:user) { create :user }
  let!(:system_log) { create :system_log, user_id: user.id }
  let!(:a_system_log) { create :system_log, user_id: user.id }
  let!(:scope_object) { Scope::Logs.new(user) }

  describe '#recent_actions' do
    subject { scope_object.recent_actions[Time.zone.today] }

    it 'returns the list of system logs' do
      expect(subject.length).to eq(2)
    end

    it 'returns array with matched logs' do
      expect(subject).to match_array [a_system_log, system_log]
    end
  end
end
