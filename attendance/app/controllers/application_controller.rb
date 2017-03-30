class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def require_user
    # redirects to the landing page if the user isn't signed in
    redirect_to '/welcome' unless current_student || current_teacher
  end

  def require_teacher
    redirect_back fallback_location: root_path unless current_teacher
  end

  def require_student
    redirect_back fallback_location: root_path unless current_student
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:first_name, :last_name, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
