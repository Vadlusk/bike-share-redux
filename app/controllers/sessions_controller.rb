class SessionsController < ApplicationController
  def new
    session[:user_id] = nil
<<<<<<< HEAD
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
=======
>>>>>>> 35448bd... Add role to users, update user_spec to test for default role.. Add dynamic nav logic to application_helper. Add nav views. Add basic styling to nav, header, form. Add user.rb to spec factories.
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
