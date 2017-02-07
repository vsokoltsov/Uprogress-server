# frozen_string_literal: true
require 'rails_helper'

describe Api::V1::DirectionsController do
  let!(:auth) { create :authorization }
  let!(:direction) { create :direction, user_id: auth.user.id }

  before { request.env['CONTENT_TYPE'] = 'application/json' }

  describe 'GET #index' do
    it 'show list of directions' do
      get :index, params: { user_id: auth.user.id }
      expect(JSON.parse(response.body)).to have_key('directions')
    end

    context 'response' do
      before { get :index, params: { user_id: auth.user.id } }

      %w(id title description percents_result steps_count finished_steps_count).each do |attr|
        it "success response contains #{attr}" do
          expect(response.body).to be_json_eql(direction.send(attr.to_sym).to_json)
            .at_path("directions/0/#{attr}")
        end
      end
    end
  end

  describe 'GET #show' do
    it 'show particular direction' do
      get :show, params: { user_id: auth.user.id, id: direction }
      expect(JSON.parse(response.body)).to have_key('direction')
    end

    context 'response' do
      before { get :show, params: { user_id: auth.user.id, id: direction } }

      %w(id title description percents_result steps finished_steps_count).each do |attr|
        it "success response contains #{attr}" do
          expect(response.body).to be_json_eql(direction.send(attr.to_sym).to_json)
            .at_path("direction/#{attr}")
        end
      end
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'create new direction' do
        expect do
          post_with_token auth, :create, user_id: auth.user.id, direction: direction.attributes
        end.to change(Direction, :count).by(1)
      end

      context 'response' do
        before do
          post_with_token auth, :create, user_id: auth.user.id, direction: direction.attributes
        end

        %w(id title description percents_result steps finished_steps_count).each do |attr|
          it "success response contains #{attr}" do
            expect(response.body).to be_json_eql(Direction.last.send(attr.to_sym).to_json)
              .at_path("direction/#{attr}")
          end
        end
      end
    end

    context 'with invalid attributes' do
      it 'doesn\'t create a new direction' do
        expect do
          post_with_token auth, :create, user_id: auth.user.id, direction: {}
        end.to change(Direction, :count).by(0)
      end
    end

    context 'errors' do
      before { post_with_token auth, :create, user_id: auth.user.id, direction: {} }

      %w(title description).each do |attr|
        it "errors array contains #{attr}" do
          expect(JSON.parse(response.body)['errors']).to have_key(attr)
        end
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      def direction_attributes(direction)
        {
          title: direction.title,
          description: 'aaa'
        }
      end

      it 'update an direction' do
        put_with_token auth, :update, user_id: auth.user.id,
                                      id: direction.id,
                                      direction: direction_attributes(direction), format: :json
        direction.reload
        expect(direction.description).to eq('aaa')
      end

      context 'response' do
        before do
          put_with_token auth, :update, user_id: auth.user.id,
                                        id: direction.id,
                                        direction: direction_attributes(direction)
          direction.reload
        end

        %w(id title description percents_result steps finished_steps_count).each do |attr|
          it "success response contains #{attr}" do
            expect(response.body).to be_json_eql(
              Direction.find(direction.id).send(attr.to_sym).to_json
            ).at_path("direction/#{attr}")
          end
        end
      end
    end

    context 'with invalid attributes' do
      it 'doesn\'t update an direction' do
        put_with_token auth, :update, user_id: auth.user.id, id: direction.id, direction: {}
        direction.reload
        expect(direction.description).to eq(direction.description)
      end

      context 'errors' do
        before do
          put_with_token auth, :update, user_id: auth.user.id, id: direction.id, direction: {}
        end

        %w(title description).each do |attr|
          it "errors array contains #{attr}" do
            expect(JSON.parse(response.body)['errors']).to have_key(attr)
          end
        end
      end
    end
  end
end
