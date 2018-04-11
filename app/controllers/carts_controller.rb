class CartsController < ApplicationController
  def create
    accessory = Accessory.find(params[:accessory_id])
    redirect_to accessory_path(accessory)
  end
end
