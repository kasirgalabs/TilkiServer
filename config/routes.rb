Rails.application.routes.draw do
  devise_for :students, path: 'students'

  devise_for :teachers, path: 'teachers'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
end
