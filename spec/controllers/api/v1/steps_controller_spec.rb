# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::StepsController do
  let!(:auth) { create :authorization }
  let!(:direction) { create :direction, user_id: auth.user.id }
  let!(:step) { create :step, direction_id: direction.id }

  before { request.env['CONTENT_TYPE'] = 'application/json' }

  describe 'GET #index' do
    before do
      get :index, params: { user_id: auth.user.id, direction_id: direction.id }
    end

    %w[id title description is_done].each do |attr|
      it "success response contains #{attr}" do
        expect(response.body).to be_json_eql(
          step.send(attr.to_sym).to_json
        ).at_path("steps/0/#{attr}")
      end
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'create a new step' do
        expect do
          post_with_token auth, :create, user_id: auth.user.id, direction_id: direction.id,
                                         step: step.attributes
        end.to change(Step, :count).by(1)
      end

      it 'increment the steps count value' do
        post_with_token auth, :create, user_id: auth.user.id, direction_id: direction.id,
                                       step: step.attributes
        direction.reload
        expect(direction.steps_count).to eq(direction.steps.size)
      end

      context 'response' do
        before do
          post_with_token auth, :create, user_id: auth.user.id, direction_id: direction.id,
                                         step: step.attributes
        end

        %w[id title description is_done].each do |attr|
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
          post_with_token auth, :create, user_id: auth.user.id, direction_id: direction.id, step: {}
        end.to change(Step, :count).by(0)
      end

      context 'error' do
        before do
          post_with_token auth, :create, user_id: auth.user.id, direction_id: direction.id, step: {}
        end

        %w[title description].each do |attr|
          it "errors array contains #{attr}" do
            expect(JSON.parse(response.body)['errors']).to have_key(attr)
          end
        end
      end
    end
  end

  describe 'PUT #update' do
    def steps_attributes(step)
      {
        title: step.title,
        description: 'aaa'
      }
    end

    context 'with valid attributes' do
      it 'update step' do
        put_with_token auth, :update, direction_id: direction.id,
                                      user_id: auth.user.id, id: step.id,
                                      step: steps_attributes(step)
        step.reload
        expect(step.description).to eq('aaa')
      end

      context 'response' do
        before do
          put_with_token auth, :update, direction_id: direction.id,
                                        user_id: auth.user.id, id: step.id,
                                        step: steps_attributes(step)

          step.reload
          expect(step.description).to eq('aaa')
        end

        %w[id title description is_done].each do |attr|
          it "success response contains #{attr}" do
            expect(response.body).to be_json_eql(
              Step.find(step.id).send(attr.to_sym).to_json
            ).at_path("step/#{attr}")
          end
        end
      end
    end

    context 'with invalid attributes' do
      it 'doesn\'t update step' do
        put_with_token auth, :update, user_id: auth.user.id, direction_id: direction.id,
                                      id: step.id, step: {}
        step.reload
        expect(step.description).to eq(step.description)
      end

      context 'errors' do

        before do
          put_with_token auth, :update, user_id: auth.user.id, direction_id: direction.id,
                                        id: step.id, step: {}
        end

        %w[title description].each do |attr|
          it "errors array contains #{attr}" do
            expect(JSON.parse(response.body)['errors']).to have_key(attr)
          end
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'delete step' do
      expect do
        delete_with_token auth, :destroy, direction_id: direction.id,
                                          user_id: auth.user.id, id: step.id
      end.to change(Step, :count).by(-1)
    end
  end
end
