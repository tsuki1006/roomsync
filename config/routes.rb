Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get 'service-worker' => 'rails/pwa#service_worker', as: :pwa_service_worker
  get 'manifest' => 'rails/pwa#manifest', as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"

  root to: 'home#show'

  scope module: :documents do
    resource :privacy_policy, only: [:show]
    resource :terms_of_service, only: [:show]
  end

  scope module: :apps do

    scope :rooms do
      resource :membership, only: [:new, :create]
    end

    resource :my_room, only: [:show], path: 'myroom'
    resources :rooms, only: [ :show, :new, :create ] do

      scope module: :in_rooms do
        resources :schedules do
          resource :participation, only: [ :create, :destroy ]
        end
        resources :members, only: [:show]
      end
    end
  end

  scope module: :mypage do
    resource :profile, path: 'mypage', only: [:show, :edit, :update] do
      resources :created_schedules, path: 'created', only: [:index]
      resources :participated_schedules, path: 'participated', only: [:index]
    end
  end

end
