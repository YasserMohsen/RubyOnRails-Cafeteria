Rails.application.routes.draw do

  devise_for :users, only: :sessions

  get 'orders/index'
  resources :orders, only: [:index, :new, :create, :update, :destroy]

  root to: "orders#index"

  namespace 'admin' do
    match "/", to: "dashboard#index", via: [:get]
    match "/checks", to: "checks#index", via: [:get]
    resources :users, except: :show
    resources :products, except: :show
    resources :categories, except: :show
    resources :rooms, except: :show
    resources :orders, only: [:new, :create]
  end

  mount ActionCable.server => '/cable'
end
