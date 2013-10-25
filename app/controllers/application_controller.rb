class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  after_filter :store_location

  def store_location
    if (request.fullpath != "/users/sign_in" &&
        request.fullpath != "/users/sign_up" &&
        request.fullpath != "/users/password" &&
        !request.xhr?)
      session[:previous_url] = request.fullpath
    end
  end

  def redirect_back_or(default)
    redirect_to(session[:previous_url] || default)
    session.delete(:previous_url)
  end

protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:first_name, :last_name, :country, :city, :region,
                   :postal_code, :phone1, :phone2, :email, :password,
                   :password_confirmation, :current_password, :first_name_public,
                   :last_name_public, :email_public)
    end
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:first_name, :last_name, :country, :city, :region,
                   :postal_code, :phone1, :phone2, :email, :password,
                   :password_confirmation, :first_name_public, :last_name_public,
                   :email_public)
    end
  end

  # def after_inactive_sign_up_path_for(user)
  #   previous_url = session[:previous_url]
  #   session.delete(:previous_url)
  #   user_path(user) || new_bicycle_path
  # end

  def after_sign_up_path_for(user)
    user_path(user)
  end

  def after_sign_in_path_for(user)
    user_path(user)
  end

  def after_sign_out_path_for(user)
    root_path
  end
end
