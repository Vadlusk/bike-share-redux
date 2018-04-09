class UsersController < ApplicationController
  def new
    session[:user_id] = nil
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Logged in as #{@user.username}"
      redirect_to '/dashboard'
    else
      flash.now[:error] = "Failed to create new account. Please try again."
      render :new
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :password, :email)
    end
end
