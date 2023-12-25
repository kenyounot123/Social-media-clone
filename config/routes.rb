Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  # get '/users/edit' => "users#edit", as: :create_profile
  # Defines the root path route ("/")
  root "posts#index", as: :dashboard

  resources :posts do 
    member do 
      patch 'like', to: 'likes#update'
    end
    resources :comments
  end

  resources :users
end
