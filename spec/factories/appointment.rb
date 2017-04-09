# frozen_string_literal: true
FactoryGirl.define do
  factory :appointment do
    date { Time.zone.now + 1.day }
    message 'Message'
    repeats 'never'
  end
end
