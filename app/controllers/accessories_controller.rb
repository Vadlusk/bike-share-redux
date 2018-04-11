class AccessoriesController < ApplicationController
  def show
    @accessory = Accessory.find(params[:id])
    @active = @accessory.active?
  end
end
