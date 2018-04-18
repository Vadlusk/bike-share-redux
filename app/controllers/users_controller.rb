class UsersController < ApplicationController
  def new
    session[:user_id] = nil
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Created a new account"
      redirect_to dashboard_path
    else
      flash.now[:error] = "Failed to create a new account"
      render :new
    end
  end

  def show
    @user = User.find(session[:user_id])
  end

  def edit
    @user = User.find(session[:user_id])
  end

  def update
    @user = User.find(session[:user_id])
    @user.update(user_params)
    if @user.save
      flash.notice = 'This user has been updated.'
      redirect_to dashboard_path
    else
      flash.notice = 'Failed to update account information'
      render :edit
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation, :email)
    end
end
