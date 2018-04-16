class Admin::UsersController < Admin::BaseController
  def show
    @user   = current_user
    if params[:status]
      @orders = Order.where(status: params[:status])
    else
      @orders = Order.order(:created_at)
    end
  end
end
