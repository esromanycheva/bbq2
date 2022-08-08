Rails.application.routes.draw do
  resources :photos
  resources :subscriptions
  resources :comments

  devise_scope :user do
    # Redirests signing out users back to sign-in
    get "users", to: "devise/sessions#new"
  end

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  root "events#index"

  resources :events do
    resources :comments, only: [:create, :destroy]
    resources :subscriptions, only: [:create, :destroy]
    resources :photos, only: [:create, :destroy]

    post :show, on: :member
  end

  resources :users, only: [:show, :edit, :update]
end
