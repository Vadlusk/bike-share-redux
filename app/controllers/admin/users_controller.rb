class Admin::UsersController < Admin::BaseController
  before_action :require_admin

  def show
    @all_orders = Order.all
    @user       = current_user
    if params[:status]
      @orders = Order.where(status: params[:status])
    else
      @orders = Order.order(:created_at)
    end
  end

  private
    def require_admin
      render file: 'public/404' unless current_user.admin?
    end
end
