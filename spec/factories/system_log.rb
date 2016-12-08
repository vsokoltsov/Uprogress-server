# frozen_string_literal: true
FactoryGirl.define do
  factory :system_log do
    operation 'create'
    data do
      {
        klass: 'Direction',
        attribute: create(:direction, user_id: user_id).as_json
      }
    end
  end
end
