Rails.application.routes.draw do
  devise_for :users
  use_doorkeeper

  namespace :api, format: false do
    namespace :v1 do
      get :me, to: 'users#me'
      resources :users, only: [:create, :show, :update]
      resources :devices, only: [:create, :destroy]
      resources :networks, only: [:index, :create, :update, :destroy]
      resources :connections, only: [:index, :create, :destroy] do
        post :approve, to: 'connections#approve'
        post :reject, to: 'connections#reject'
      end
    end
  end
end
