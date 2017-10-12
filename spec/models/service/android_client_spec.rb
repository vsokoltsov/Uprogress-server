# frozen_string_literal: true

require 'spec_helper'

describe Service::AndroidClient do
  let!(:device_ids) do
    [
      'c9E000EClDE:APA91bG0A1O-soLjYt46dHEiZ-YkXG5dYCa5yg3kbz
      cwjxb0sHa0js3TmcITmhagnmpIBo9bSwTfSdfoiYm-bx
      TbtYQAP3AwQ_YCkuFIMrQCp-bAHZ8o8Hq4APQvurmjHPzQX97qQL2s'
    ]
  end

  let!(:android_client) { Service::AndroidClient.new(ENV['FIREBASE_API_KEY']) }

  describe '#send_request' do

    before do
      VCR.use_cassette('success_fcm_response') do
        @response = android_client.send_request(device_ids, 'Test')
      end
    end

    it 'response status is success' do
      expect(@response.code).to eq(200)
    end

    it 'body receives success information' do
      json = JSON.parse(@response.body)
      expect(json['success']).to eq 1
    end
  end
end
