class SessionsController < ApplicationController
  def new
    session[:user_id] = nil
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to '/dashboard'
    else
      flash.now[:error] = "Invalid username and/or password"
      render :new
    end
  end
end
