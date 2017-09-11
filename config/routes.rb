Rails.application.routes.draw do
  get 'home/index'

  devise_for :admins
  namespace :api do
    namespace :v1 do
      resources :students
    end
  end
  
  root 'home#index'
end
