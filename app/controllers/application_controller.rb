class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    @curr_user ||= User.find_by(session_token: session[:session_token])
    #Lazy initialization prevents needless queries to the database if current 
    #user is already known
  end

  def log_in_user!(user)
    session[:session_token] = user.reset_session_token!
  end

  def log_out!
    current_user.reset_session_token!
    @curr_user = nil
    session[:session_token] = nil
  end

  def ensure_logged_in
    redirect_to new_session_url unless logged_in?
  end

  def logged_in?
    !!current_user
  end
end
