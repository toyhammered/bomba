Rails.application.routes.draw do

  devise_for :users, controllers: {registrations: 'registrations'}
  root 'home#index'

  resources :users, only: [:show, :index] do
    resources :posts, only: [:create, :destroy]
  end

  resources :pending_friendships, only: [:create, :destroy] do
    member do
      post 'accept'
    end
  end
  resources :friendships, only: [:destroy]

end
