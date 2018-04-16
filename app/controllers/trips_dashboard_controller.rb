class TripsDashboardController < ApplicationController
  def index
    @trips = Trip.all
  end
end
