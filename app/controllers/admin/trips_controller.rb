class Admin::TripsController < Admin::BaseController
  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    if @trip.save
      flash[:success] = 'You successfully created this trip'
      redirect_to trip_path(@trip)
    else
      flash[:error] = 'Failed to create new trip'
      redirect_to new_admin_trip_path
    end
  end

  private

      def trip_params
        params.require(:trip).permit(
          :duration,
          :start_date,
          :start_station_name,
          :start_station_id,
          :end_date,
          :end_station_name,
          :end_station_id,
          :bike_id,
          :subscription_type,
          :zip_code
        )
      end
end
