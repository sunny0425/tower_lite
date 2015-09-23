class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def bounce!(message, url = root_url)
    flash[:notice] = message if message
    if request.xhr?
      render(:update) {|page| page.redirect_to(url)}
    else
      redirect_to url
    end
  end

  helper_method :current_user
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_user=(user)
    session[:user_id] = user.id
    @current_user = user
  end

  def logged_in?
    current_user
  end

  def login!(user)
    p ' **' * 20
    p user.inspect
    if user
      session[:user_id] = user.id
      @current_user = user
    end
  end

  def require_login
    session[:return_to] = request.fullpath
    bounce! 'Sorry, you must login first' unless current_user
  end

end
