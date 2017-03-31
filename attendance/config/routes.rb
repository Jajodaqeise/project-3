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


  get "/courses", to: "courses#index"
  get "/courses/new", to: "courses#new", as: :new_course
  get "/courses/:id", to: "courses#show", as: :course
  get "/courses/:id/edit", to: "courses#edit", as: :edit_course
  post "/courses", to: "courses#create"
  patch "/courses/:id", to: "courses#update"
  delete "/courses/:id", to: "courses#destroy", as: :delete_course

  get "/courses/:course_id/class_dates/new", to: "class_dates#new", as: :new_class_date
  post "/courses/:course_id/class_dates", to: "class_dates#create", as: :create_class_date
  patch "/class_dates/:id", to: "class_dates#update"
  delete "/class_dates/:id", to: "class_dates#destroy", as: :delete_class_date

  post "/attenders", to: "attenders#create", as: :check_in

  get "/courses/:id/students", to: "students#index", as: :students
  get "/student/:id", to: "student#show", as: :student

  get "/teachers/:id", to: "teachers#show", as: :teacher

  # isolate the api controllers under a namespace in Rails this is fairly simple, just create a folder under the app/controllers named api
  # Rails will automatically map that namespace to a directory matching the name under the controllers folder, in our case the api/ directory.
  # we are going to be working with JSON, so that we spcify this format as the default one, and also subdomain defined
  namespace :api, defaults: { format: :json } do
    resources :find_schools
    get "/find_classes/course/:course_id", to: "find_classes#index"
    post "/find_classes/course/:course_id", to: "find_classes#create"
    patch "/find_classes/:id", to: "find_classes#update"
    delete "/find_classes/:id", to: "find_classes#destroy"
  end

end
