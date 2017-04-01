Rails.application.routes.draw do
  devise_for :teachers
  devise_for :students
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Root needs to be where we want to redirect the viewer when they
  #   log in for devise
  root to: "courses#index"

  # We can have the landing page be on a different root to redirect
  #   users that not logged in to -- configured in the application_controller.rb file
  get "/welcome", to: "site#index", as: :landing
  get "/welcome/student", to: "site#student", as: :student_landing
  get "/welcome/teacher", to: "site#teacher", as: :teacher_landing

  get "/courses", to: "courses#index", as: :courses
  get "/courses/new", to: "courses#new", as: :new_course
  get "/courses/:id", to: "courses#show", as: :course
  get "/courses/:id/edit", to: "courses#edit", as: :edit_course
  post "/courses", to: "courses#create"
  patch "/courses/:id", to: "courses#update"
  delete "/courses/:id", to: "courses#destroy", as: :delete_course


  get "/courses/:course_id/class_dates", to: "class_dates#index", as: :class_dates
  get "/class_dates/:id", to: "class_dates#show", as: :class_date
  post "/courses/:course_id/class_dates", to: "class_dates#create", as: :create_class_date
  patch "/class_dates/:id", to: "class_dates#update", as: :update_class_date
  get "/courses/:course_id/class_dates/new", to: "class_dates#new", as: :new_class_date
  get "/class_dates/:id/edit", to: "class_dates#edit", as: :edit_class_date
  delete "/class_dates/:id", to: "class_dates#destroy", as: :delete_class_date

  get "/class_patterns", to: "class_patterns#index", as: :class_patterns
  get "/class_pattern/:id", to: "class_patterns#show", as: :class_pattern
  post "/class_patterns", to: "class_patterns#create", as: :create_class_pattern
  patch "/class_pattern/:id", to: "class_patterns#update", as: :update_class_pattern
  delete "/class_patterns/:id", to: "class_patterns#destroy", as: :delete_class_pattern

  post "/attenders", to: "attenders#create", as: :check_in

  get "/courses/:id/students", to: "students#index", as: :students
  get "/student/:id", to: "student#show", as: :student

  get "/teachers/:id", to: "teachers#show", as: :teacher

  post "students/:student_id/courses/:id/register", to: "courses_students#create", as: :register_course

  # isolate the api controllers under a namespace in Rails this is fairly simple, just create a folder under the app/controllers named api
  # Rails will automatically map that namespace to a directory matching the name under the controllers folder, in our case the api/ directory.
  # we are going to be working with JSON, so that we spcify this format as the default one, and also subdomain defined
  namespace :api, defaults: { format: :json } do
    resources :find_schools
    resources :class_dates
    resources :class_patterns
  end

end
