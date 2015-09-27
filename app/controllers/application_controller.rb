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
    !current_user.nil?
  end

  def login!(user)
    if user
      session[:user_id] = user.id
      @current_user = user
    end
  end

  def logout!
    session.delete(:user_id)
    @current_user = nil
  end

  def require_login
    session[:return_to] = request.fullpath
    bounce! 'Sorry, you must login first' unless current_user
  end

  helper_method :current_team
  def current_team
    return @current_team if @current_team.present?
    if session[:team_id]
      @current_team = Team.find(session[:team_id])
    else
      @current_team = current_user.teams.first
    end 
  end

end
