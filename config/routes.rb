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
  get 'enroll_course', to: 'courses#enroll'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
end
