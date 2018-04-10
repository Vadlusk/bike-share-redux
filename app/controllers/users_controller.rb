class UsersController < ApplicationController
  def new
    session[:user_id] = nil
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
<<<<<<< HEAD
<<<<<<< HEAD
      session[:user_id] = @user.id
=======
>>>>>>> f92b1d7... Add sessions#new view. Add users migration, controller, model, model tests for validations. Update routes
=======
      session[:user_id] = @user.id
>>>>>>> 35448bd... Add role to users, update user_spec to test for default role.. Add dynamic nav logic to application_helper. Add nav views. Add basic styling to nav, header, form. Add user.rb to spec factories.
      flash[:success] = "Logged in as #{@user.username}"
      redirect_to '/dashboard'
    else
      flash.now[:error] = "Failed to create new account. Please try again."
      render :new
    end
  end

<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 35448bd... Add role to users, update user_spec to test for default role.. Add dynamic nav logic to application_helper. Add nav views. Add basic styling to nav, header, form. Add user.rb to spec factories.
  def show
    @user = User.find(session[:user_id])
  end

<<<<<<< HEAD
  private
    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation, :email)
=======
  private
    def user_params
      params.require(:user).permit(:username, :password, :email)
>>>>>>> f92b1d7... Add sessions#new view. Add users migration, controller, model, model tests for validations. Update routes
=======
  private
    def user_params
<<<<<<< HEAD
      params.require(:user).permit(:username, :password, :email, :role)
>>>>>>> 35448bd... Add role to users, update user_spec to test for default role.. Add dynamic nav logic to application_helper. Add nav views. Add basic styling to nav, header, form. Add user.rb to spec factories.
=======
      params.require(:user).permit(:username, :password, :password_confirmation, :email)
>>>>>>> 3d123c7... Add password_confirmation to user_params
    end
end
