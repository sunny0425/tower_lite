class UserSessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: user_session_params[:email]).try(:authenticate, user_session_params[:password]) 
    if @user
      login!(@user)
      redirect_to root_path, notice: 'Login successfully'
    else
      @user = User.new(email: user_session_params[:email])
      flash[:alert] = 'Sorry, you email or password is not right, please try again'
      render :new 
    end 
  end

  def destroy
    logout!
    redirect_to root_path, notice: 'Logout successfully'
  end

  private
  def user_session_params
    params.require(:user_session).permit(:email, :password)
  end
end
