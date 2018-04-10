class ChangeMaxWindSpeedMph < ActiveRecord::Migration[5.1]
  def change
    rename_column :conditions, :max_wind_speed_mph, :max_wind_Speed_mph
  end
end
