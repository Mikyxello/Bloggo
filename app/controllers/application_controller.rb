class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  
  def render_404
    respond_to do |format|
      format.html { render file: "#{Rails.root}/public/404.html", layout: 'layouts/application', status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name, :surname, :email])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username,:name, :surname, :email, :birth_date, :password, :password_confirmation, :avatar_image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username,:name, :surname, :email, :birth_date, :password, :password_confirmation, :avatar_image, :current_password])
  end

  #def banned?
  #  if current_user.banned == true
  #   sign_out current_user
  #    flash[:error] = "This account has been suspended...."
  #    root_path
  #  end
  #end
end
