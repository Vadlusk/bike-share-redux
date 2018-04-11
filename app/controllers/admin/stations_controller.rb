class Admin::StationsController < Admin::BaseController
  def edit
    @station = Station.find_by_slug(params[:id])
  end

  def update
    @station = Station.find_by_slug(params[:id])
    @station.update(station_params)
    if @station.save
      flash.notice = 'This station has been updated.'
      redirect_to station_path(@station)
    else
      flash.notice = 'This station has NOT been updated.'
      render :edit
    end
  end

  private

  def station_params
    params.require(:station).permit(:name, :dock_count, :city, :installation_date, :lat, :long)
  end
end
