# frozen_string_literal: true
Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :directions do
        resources :steps
      end
    end
  end
end
