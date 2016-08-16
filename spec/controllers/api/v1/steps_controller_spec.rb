# frozen_string_literal: true
require 'rails_helper'

describe Api::V1::StepsController do
  let!(:direction) { create :direction }
  let!(:step) { create :step, direction_id: direction.id }

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'create a new step' do
        expect do
          post :create, direction_id: direction.id, step: step.attributes
        end.to change(Step, :count).by(1)
      end

      context 'response' do
        before do
          post :create, direction_id: direction.id, step: step.attributes
        end

        %w(id title description is_done).each do |attr|
          it "success response contains #{attr}" do
            expect(response.body).to be_json_eql(
              Step.last.send(attr.to_sym).to_json
            ).at_path("step/#{attr}")
          end
        end
      end
    end

    context 'with invalid attributes' do
      it 'doesn\'t create a new step' do
        expect do
          post :create, direction_id: direction.id, step: {}
        end.to change(Step, :count).by(0)
      end

      context 'error' do
        before { post :create, direction_id: direction.id, step: {} }

        %w(title description).each do |attr|
          it "errors array contains #{attr}" do
            expect(JSON.parse(response.body)['errors']).to have_key(attr)
          end
        end
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid attributes' do

    end

    context 'with invalid attributes' do

    end
  end

  describe 'DELETE #destroy' do

  end
end
