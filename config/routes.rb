Rails.application.routes.draw do
  get 'checks/index'

  devise_for :users, only: :sessions

  get 'home/index'
  resources :orders, only: [:index, :new, :create]

  root to: "home#index"

  namespace 'admin' do
    match "/", to: "dashboard#index", via: [:get]
    match "/checks", to: "checks#index", via: [:get]
    resources :users, except: :show
    resources :products, except: :show
    resources :categories, except: :show
    resources :rooms, except: :show
  end

  mount ActionCable.server => '/cable'
end
