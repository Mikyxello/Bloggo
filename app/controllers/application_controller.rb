class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def render_404
  	render file: "#{Rails.root}/public/404.html", layout: 'layouts/application', status: 404
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name, :surname, :email])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username,:name, :surname, :email, :birth_date, :password, :password_confirmation, :avatar_image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username,:name, :surname, :email, :birth_date, :password, :password_confirmation, :avatar_image, :current_password])
  end
end
