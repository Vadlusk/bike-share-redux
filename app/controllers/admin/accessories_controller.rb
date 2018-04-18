class Admin::AccessoriesController < Admin::BaseController
  def index
    @accessories = Accessory.all
  end

  def new
    @accessory = Accessory.new
  end

  def create
    @accessory = Accessory.new(accessory_params)
    if @accessory.save
      flash[:notice] = 'You successfully created this accessory'
      redirect_to admin_bike_shop_path
    else
      flash[:notice] = 'Accessory has NOT been created, please make sure you fill in all of the form'
      render :new
    end
  end

  def edit
    @accessory = Accessory.find(params[:id])
  end

  def update
    @accessory = Accessory.find(params[:id])
    @accessory.update(accessory_params)
    if @accessory.save
      flash[:notice] = "Accessory has been updated."
      redirect_to admin_bike_shop_path
    else
      flash[:notice] = "Accessory has NOT been updated."
      render :edit
    end
  end

  def status
    accessory = Accessory.find(params[:id])
    accessory.retired? ? accessory.active! : accessory.retired!
    redirect_to admin_bike_shop_path
  end

  private

  def accessory_params
    params.require(:accessory).permit(:title, :description, :price, :image_url, :status)
  end
end
