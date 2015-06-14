class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= session[:user_id] && User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user !=nil
  end

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in do this action"
      redirect_to login_url 
    end
  end

end
