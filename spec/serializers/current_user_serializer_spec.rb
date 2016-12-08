# frozen_string_literal: true
require 'rails_helper'

describe CurrentUserSerializer do
  let!(:user) { create :user }
  let!(:attachment) { create :attachment, attachable_id: user.id, attachable_type: user.class.to_s }
  let!(:serializer) { CurrentUserSerializer.new(user) }
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

    %w(id nick first_name last_name description location).each do |attr|
      it "contains #{attr}" do
        expect(object).to have_key(attr)
      end

      it "serializer #{attr} value equal to object #{attr} value" do
        expect(object[attr]).to eq(user.send(attr.to_sym))
      end
    end
  end

  describe 'relations' do
    let!(:object) { subject[root_key] }

    describe 'has_one :attachment' do
      it 'has steps relation key' do
        expect(object).to have_key('attachment')
      end

      context 'attachment attributes' do
        %w(id attachable_id attachable_type created_at url).each do |attr|
          it "has #{attr} key" do
            expect(object['attachment']).to have_key(attr)
          end
        end
      end
    end
  end
end
