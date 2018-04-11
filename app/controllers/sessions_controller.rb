class SessionsController < ApplicationController
  def new
    session[:user_id] = nil
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      @user.default? ? (redirect_to dashboard_path) : (redirect_to admin_dashboard_path)
    else
      flash.now[:error] = "Invalid username and/or password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path 
  end
end
