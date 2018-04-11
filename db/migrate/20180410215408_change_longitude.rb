class ChangeLongitude < ActiveRecord::Migration[5.1]
  def change
    rename_column :stations, :longitude, :long
  end
end
