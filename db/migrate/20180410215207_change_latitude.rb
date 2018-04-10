class ChangeLatitude < ActiveRecord::Migration[5.1]
  def change
    rename_column :stations, :latitude, :lat
  end
end
