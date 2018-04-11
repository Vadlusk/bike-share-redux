class Admin::UsersController < ApplicationController
  before_action :require_admin

  def show
    @user = current_user
  end

  def require_admin
    render file: 'public/404' unless current_user.admin?
  end
end
