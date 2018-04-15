class OrdersController < ApplicationController
  before_action :set_order, only: %i[show]

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
end
