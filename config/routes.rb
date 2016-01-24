Rails.application.routes.draw do

  devise_for :users, controllers: {registrations: 'registrations'}
  root 'home#index'

  resources :users, only: [:show, :index] do
    resources :posts, only: [:create, :destroy, :update, :show]
  end

  resources :pending_friendships, only: [:create, :destroy] do
    member do
      post 'accept'
    end
  end
  resources :friendships, only: [:destroy]

  resources :posts, only: [] do
    resources :comments, only: [:create, :destroy]
  end

end
