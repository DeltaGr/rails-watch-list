Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "lists#index"

  resources :lists, only: [:index, :show, :new, :create] do
    resources :bookmarks, only: [:new, :create]
  # Health check route for app status (leave as is or remove if not needed)
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # Defines the root path route ("/")
  # root "posts#index"
  # Root route (optional, set this to a relevant page in your app)
  # root "lists#index"
  end
  resources :bookmarks, only: :destroy
end
