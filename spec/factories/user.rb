# frozen_string_literal: true

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "useremail#{n}@mail.test" }
    sequence(:nick) { |n| "user#{n}name" }
    password 'example12345'
    password_confirmation 'example12345'

  end
end
