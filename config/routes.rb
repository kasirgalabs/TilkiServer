Rails.application.routes.draw do
  get 'home/index'

  devise_for :users
  authenticated :user do
    root to: 'home#index', as: :authenticated_root
  end

  root to: redirect('/users/sign_in')
  namespace :api do
    namespace :v1 do
      resources :students
    end
  end

  root 'home#index'
end
