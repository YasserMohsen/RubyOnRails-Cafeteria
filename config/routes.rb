Rails.application.routes.draw do
  devise_for :users, only: :sessions

  get 'orders/index'
  resources :orders, only: [:index, :new, :create]

  root to: "orders#index"

  namespace 'admin' do
    match "/", to: "dashboard#index", via: [:get]
    resources :users, except: :show
    resources :products, except: :show
    resources :categories, except: :show
    resources :rooms, except: :show
  end

  mount ActionCable.server => '/cable'
end
