class ConditionsDashboardController < ApplicationController
  def index
    @conditions = Condition.all
    @temp_ranges = Condition.temperature_ranges
    @precipitation_ranges = Condition.precipitation_ranges
    @wind_ranges = Condition.wind_ranges
    @visibility_ranges = Condition.visibility_ranges
  end
end
