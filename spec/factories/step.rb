# frozen_string_literal: true
FactoryGirl.define do
  factory :step do
    title 'Title'
    description 'Description'
    is_done false
  end
end
