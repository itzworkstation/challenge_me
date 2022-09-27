require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api, defaults: { format: :json } do
    scope module:'v1', path: 'v1' do
      resources :users do
        collection do
          post 'signup', to: 'users#signup'
          post 'verify_otp', to: 'users#verify_otp'
        end
      end
      resources :challenges do
        member do
          post :invite_users
          get :invite_accepted
        end
      end
    end
  end
end
