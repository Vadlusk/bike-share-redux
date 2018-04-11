class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper
  def create
    accessory = Accessory.find(params[:accessory_id])
    @cart.add_accessory(accessory.id)
    session[:cart] = @cart.contents
    flash[:success] = "You've added #{pluralize(session[:cart][accessory.id.to_s], accessory.title)} to your cart"
    redirect_to accessory_path(accessory)
  end
end
