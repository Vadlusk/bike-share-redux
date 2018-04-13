class UsersController < ApplicationController
  def new
    session[:user_id] = nil
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "New account created successfully"
      redirect_to dashboard_path
    else
      flash.now[:error] = "Failed to create new account. Please try again."
      render :new
    end
  end

  def show
    @user = User.find(session[:user_id])
  end

  private
    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation, :email)
    end
end
