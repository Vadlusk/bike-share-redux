class AccessoriesController < ApplicationController
  def show
    @accessory = Accessory.find(params[:id])
    @active    = @accessory.active?
  end

  def index
    @accessories = Accessory.where(status: 'active')
  end
end
