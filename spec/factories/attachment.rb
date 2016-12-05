# frozen_string_literal: true
FactoryGirl.define do
  factory :attachment do
    file do
      File.open(File.join(Rails.root, 'spec', 'factories', 'easytest.png'))
    end
  end
end
