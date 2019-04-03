class ApplicationController < ActionController::Base

  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def login_user!(user)
    session[:session_token] = user.reset_session_token! 
  end
  
  def logout!
    if current_user
      current_user.reset_session_token!
    end
    @current_user = nil
    session[:session_token] = nil
  end

  def logged_in?
    !!(current_user)
  end

end
