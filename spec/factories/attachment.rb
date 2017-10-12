# frozen_string_literal: true

FactoryGirl.define do
  factory :attachment do
    file do
      File.open(Rails.root.join('spec', 'factories', 'easytest.png'))
    end
  end
end
