class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authorised
  helper_method :current_user
  helper_method :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    current_user.present?
  end
  
  def authorised
    redirect_to login_path unless logged_in?
  end

end
