class Admin::StationsController < Admin::BaseController
  def new
    @station = Station.new
  end

  def create
    @station = Station.new(station_params)
    if @station.save
      flash[:notice] = 'You successfully created this station'
      redirect_to station_path(@station)
    else
      flash[:notice] = 'Station has NOT been created, please make sure you fill in all of the form'
      render :new
    end
  end

  def edit
    @station = Station.find_by_slug(params[:id])
  end

  def update
    @station = Station.find_by_slug(params[:id])
    @station.update(station_params)
    if @station.save
      flash[:notice] = 'This station has been updated.'
      redirect_to station_path(@station)
    else
      flash[:notice] = 'This station has NOT been updated.'
      render :edit
    end
  end

  def destroy
    @station = Station.find_by_slug(params[:id])
    if @station.destroy
      flash[:notice] = "You deleted the station successfully."
      redirect_to stations_path
    else
      flash[:notice] = "You failed to deleted the station."
      render stations_path
    end
  end

  private

  def station_params
    params.require(:station).permit(:name, :dock_count, :city, :installation_date, :lat, :long)
  end
end
