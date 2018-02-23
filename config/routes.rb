Rails.application.routes.draw do
  get 'teachers/index'
  get 'students/index'
  get 'teachers/my_courses'
  get 'teachers/exam_dates'
  get 'students/my_courses'
  get 'students/exam_dates'
  devise_for :students, path: 'students'
  devise_for :teachers, path: 'teachers'
  resources :courses
  post 'courses/:id/enroll', to: 'courses#enroll', as: 'enroll'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  
  get 'tilki/list_exams'
  get 'tilki/check_in'
  get 'tilki/verify_key'
  post 'tilki/upload'
  
end
