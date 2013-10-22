class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  after_filter :store_location
          
  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    if (request.fullpath != "/users/sign_in" &&
        request.fullpath != "/users/sign_up" &&
        request.fullpath != "/users/password" &&
        !request.xhr?) # don't store ajax calls
      session[:previous_url] = request.fullpath 
    end
  end

  def redirect_back_or(default)
    redirect_to(session[:previous_url] || default)
    session.delete(:previous_url)
  end

protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name, :country, :city, :region, :postal_code, :phone1, :phone2, :email, :password, :password_confirmation, :current_password) } #fixme break onto multiple lines
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :country, :city, :region, :postal_code, :phone1, :phone2, :email, :password, :password_confirmation) }
  end
end
