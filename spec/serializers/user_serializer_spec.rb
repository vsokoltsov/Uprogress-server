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
end
