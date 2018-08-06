class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name, :surname, :email])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username,:name, :surname, :email, :password, :password_confirmation, :avatar_image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username,:name, :surname, :email, :password, :password_confirmation, :avatar_image, :current_password])
  end
end
