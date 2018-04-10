class UsersController < ApplicationController
  def new
    session[:user_id] = nil
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
<<<<<<< HEAD
      session[:user_id] = @user.id
=======
>>>>>>> f92b1d7... Add sessions#new view. Add users migration, controller, model, model tests for validations. Update routes
      flash[:success] = "Logged in as #{@user.username}"
      redirect_to '/dashboard'
    else
      flash.now[:error] = "Failed to create new account. Please try again."
      render :new
    end
  end

<<<<<<< HEAD
  def show
    @user = User.find(session[:user_id])
  end

  private
    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation, :email)
=======
  private
    def user_params
      params.require(:user).permit(:username, :password, :email)
>>>>>>> f92b1d7... Add sessions#new view. Add users migration, controller, model, model tests for validations. Update routes
    end
end
