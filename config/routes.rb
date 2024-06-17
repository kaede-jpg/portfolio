Rails.application.routes.draw do
  resource :user do
    member do
      get :activate
    end
  end
  resources :password_resets, only: %i[new create edit update]

  get 'login' => 'user_sessions#new', as: :login
  post 'login' => 'user_sessions#create'
  delete 'logout' => 'user_sessions#destroy', as: :logout

  post 'oauth/callback' => 'oauths#callback'
  get 'oauth/callback' => 'oauths#callback'
  get 'oauth/:provider' => 'oauths#oauth', as: :auth_at_provider

  resources :relationships, only: %i[create destroy]
  get 'relationships/menu'
  patch 'relationships/relationship_code'

  resources :records, only: %i[index create destroy] do
    resources :comments, only: %i[create destroy], shallow: true
    resources :stamped_records, only: %i[create], shallow: true
  end

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root 'static_pages#top'
end
