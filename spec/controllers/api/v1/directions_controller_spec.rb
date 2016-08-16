# frozen_string_literal: true
require 'rails_helper'

describe Api::V1::DirectionsController do
  let!(:direction) { create :direction }

  describe 'GET #index' do
    it 'show list of directions' do
      get :index
      expect(JSON.parse(response.body)).to have_key('directions')
    end

    context 'response' do
      before { get :index }

      %w(id title description percents_result).each do |attr|
        it "success response contains #{attr}" do
          expect(response.body).to be_json_eql(direction.send(attr.to_sym).to_json)
            .at_path("directions/0/#{attr}")
        end
      end
    end
  end

  describe 'GET #show' do
    it 'show particular direction' do
      get :show, id: direction
      expect(JSON.parse(response.body)).to have_key('direction')
    end

    context 'response' do
      before { get :show, id: direction }

      %w(id title description percents_result steps).each do |attr|
        it "success response contains #{attr}" do
          expect(response.body).to be_json_eql(direction.send(attr.to_sym).to_json)
            .at_path("direction/#{attr}")
        end
      end
    end
  end

  describe 'POST #create' do

  end

  describe 'PUT #update' do

  end
end
