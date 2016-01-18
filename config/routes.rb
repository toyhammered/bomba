Rails.application.routes.draw do

  devise_for :users, controllers: {registrations: 'registrations'}
  root 'home#index'

  resources :users, only: [:show, :index]

  # I don't think I need to specify :accept inside the resources do I?
  resources :friendships, only: [:create, :destroy] do
    member do
      put :accept
    end
  end

end
