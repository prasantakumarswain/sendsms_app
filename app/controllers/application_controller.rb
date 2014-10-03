class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #def configure_permitted_parameters
  #  devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation,:name, :phone, :verified) }
  #end
  #
  # helper_method :current_user
  #
  #def current_user
  #  @current_user ||= User.find(session[:user_id]) if session[:user_id]
  #end
end
