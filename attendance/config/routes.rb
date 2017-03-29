Rails.application.routes.draw do
  devise_for :teachers
  devise_for :students
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "site#index"

  get "/courses", to: "courses#index"
  get "/courses/new", to: "courses#new", as: :new_course
  get "/courses/:id", to: "courses#show", as: :course
  get "/courses/:id/edit", to: "courses#edit", as: :edit_course
  post "/courses", to: "courses#create"
  patch "/courses/:id", to: "courses#update"
  delete "/courses/:id", to: "courses#destroy", as: :delete_course

  get "/class_dates/new", to: "class_dates#new", as: :new_class_date
  post "/class_dates", to: "class_dates#create"
  get "/class_dates/:id/edit", to: "class_dates#edit", as: :edit_class_date
  patch "/class_dates/:id", to: "class_dates#update"
  delete "/class_dates/:id", to: "class_dates#destroy", as: :delete_class_date

  post "/attenders", to: "attenders#new", as: :check_in

  get "/courses/:id/students", to: "students#index", as: :students
  get "/student/:id", to: "student#show", as: :student

  get "/teachers/:id", to: "teachers#show", as: :teacher

end
