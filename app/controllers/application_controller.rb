class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    attributes = [:name, :surname, :email, :password, :password_confirmation]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
  end
  
  def after_sign_in_path_for(resource)
    if resource.is_a?(Teacher)
      teachers_index_path  
    else
      students_index_path
    end
  end
  
end