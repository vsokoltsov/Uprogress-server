# frozen_string_literal: true
require 'rails_helper'

describe Api::V1::AttachmentsController do
  let!(:auth) { create :authorization }
  let!(:file) do
    Rack::Test::UploadedFile.new(
      File.join(Rails.root, 'spec', 'factories', 'easytest.png')
    )
  end

  def attachment_attributes
    {
      file: file,
      attachable_type: 'User'
    }
  end

  describe 'POST #create' do
    it 'creates new attachment' do
      expect do
        post :create, params: attachment_attributes
      end.to change(Attachment, :count).by(1)
    end

    context 'success response' do
      before { post :create, params: attachment_attributes }

      %w(attachable_type attachable_id url id).each do |attr|
        it "contains #{attr} attribute" do
          expect(JSON.parse(response.body)['attachment']).to have_key(attr)
        end
      end
    end
  end
end
