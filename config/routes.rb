Rails.application.routes.draw do


  devise_for :users, controllers: {registrations: 'registrations'}
  root 'home#index'

  resources :users, only: [:show, :index] do
    member do
      patch 'avatar', to: 'users#avatar'
      get 'about', to: 'users#about'
    end
  end

  resources :pending_friendships, only: [:create, :destroy] do
    member do
      post 'accept'
    end
  end
  resources :friendships, only: [:destroy]

  resources :posts, only: [:show] do
    resources :comments, only: [:create, :destroy]
  end

  resources :comments, only: [] do
    member do
      put "like", to: "comments#upvote"
      put "dislike", to: "comments#downvote"
    end
  end

  resources :activities, only: [:index]

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [:index]
      resources :posts do
        member do
          put "like", to: "posts#upvote"
          put "dislike", to: "posts#downvote"
        end
        resources :comments, only: [:index, :show]
      end
    end
  end

end
