Rails.application.routes.draw do
  get 'home/index'

  devise_for :users, controllers: { registrations: "registrations"}
  authenticated :user do
    root to: 'home#index', as: :authenticated_root
  end

  namespace :api do
    namespace :v1 do
      resources :students
    end
  end

  resources :exams

  root to: redirect('/users/sign_in')
end
