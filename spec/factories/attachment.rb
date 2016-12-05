# frozen_string_literal: true
FactoryGirl.define do
  factory :attachment do
    file do
      Rack::Test::UploadedFile.new(
        File.join(
          Rails.root, 'spec', 'factories', 'easytest.png'
        )
      )
    end
  end
end
