# frozen_string_literal: true
FactoryGirl.define do
  factory :authorization do
    platform 'OS X'
    platform_version '10.11.3'
    app_name 'Chrome'
    app_version '49.0.2623.87'
    provider 'Estudy'
    user { create(:user) }
  end
end
