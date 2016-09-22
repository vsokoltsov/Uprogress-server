# frozen_string_literal: true
Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :registrations, only: [:create]
      resources :sessions, only: [:create, :destroy] do
        get :current, on: :collection
      end
      resources :attachments, only: [:create]
      resources :users do
        resources :directions do
          resources :steps
        end
      end
    end
  end
end
