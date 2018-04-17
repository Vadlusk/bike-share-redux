class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def show
    @accessories = Accessory.where(id: @cart.contents.keys)
  end

  def create
    accessory = Accessory.find(params[:accessory_id])

    @cart.add_accessory(accessory.id)
    session[:cart] = @cart.contents
    flash[:success] = "You've added #{pluralize(session[:cart][accessory.id.to_s], accessory.title)} to your cart"
    redirect_to bike_shop_path
  end

  def destroy
    accessory = Accessory.find(params[:accessory_id])

    @cart.remove_accessory(params[:accessory_id])
    flash[:success] = %Q(Successfully removed #{view_context.link_to(accessory.title, accessory_path(accessory))} from your cart)
    redirect_to '/cart'
  end

  def update
    accessory = Accessory.find(params[:accessory_id])
    if params[:delta] == 'increase'
      flash[:success] = "You've added another #{accessory.title} to your cart"
      @cart.increment_accessory(params[:accessory_id])
    elsif params[:delta] == 'decrease'
      @cart.decrement_accessory(params[:accessory_id])
      if @cart.contents.keys.include?(params[:accessory_id])
        flash[:success] = "You've removed a #{accessory.title} from your cart"
      else
        flash[:success] = %Q(Successfully removed #{view_context.link_to(accessory.title, accessory_path(accessory))} from your cart)
      end
    end
    redirect_to '/cart'
  end
end
