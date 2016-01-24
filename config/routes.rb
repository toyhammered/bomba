Rails.application.routes.draw do

  devise_for :users, controllers: {registrations: 'registrations'}
  root 'home#index'

  resources :users, only: [:show, :index]

  resources :pending_friendships, only: [:create, :destroy] do
    member do
      post 'accept'
    end
  end
  resources :friendships, only: [:destroy]

  resources :posts, only: [:create, :destroy, :update, :show] do
    resources :comments, only: [:create, :destroy]
  end

end
