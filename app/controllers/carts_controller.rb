class CartsController < ApplicationController
  def create
    accessory       = Accessory.find(params[:accessory_id])
    flash[:success] = "You've added 1 #{accessory.title} to your cart"
    redirect_to accessory_path(accessory)
  end
end
