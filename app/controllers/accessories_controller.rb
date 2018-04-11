class AccessoriesController < ApplicationController
  def show
    @accessory = Accessory.find(params[:id])
    @cart = Cart.new(session[:cart])
    @active    = @accessory.active?
  end

  def index
    @accessories = Accessory.where(status: 'active')
  end
end
