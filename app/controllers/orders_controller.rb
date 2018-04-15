class OrdersController < ApplicationController
  before_action :set_order, only: %i[show require_correct_user]
  before_action :require_correct_user, only: %i[show]

  def create
    @order = Order.new(user_id: params[:user_id])
    if @order.save
      flash[:success] = "Successfully submitted your order totaling #{@cart.total_price}"
      @cart.checkout(@order)
      session[:cart] = Hash.new(0)
      redirect_to dashboard_path
    else
      redirect_to cart_path
    end
  end

  def show; end

  private

    def set_order
      @order = Order.find(params[:id])
    end

    def require_correct_user
      render file: 'public/404' unless current_user.id == @order.id || current_admin?
    end
end
