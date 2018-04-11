class CartsController < ApplicationController
  def create
    accessory       = Accessory.find(params[:accessory_id])
    session[:cart] ||= Hash.new(0)
    session[:cart][accessory.id.to_s] = session[:cart][accessory.id.to_s] + 1
    flash[:success] = "You've added #{session[:cart][accessory.id.to_s]} #{accessory.title} to your cart"
    redirect_to accessory_path(accessory)
  end
end
