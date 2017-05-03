Rails.application.routes.draw do
  devise_for :users

  get 'home/index'
  root to: "home#index"

  namespace 'admin' do
    resources :users, except: :show
    resources :products, except: :show
    resources :categories, except: :show
    resources :rooms, except: :show
  end
end
