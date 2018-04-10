class CreateStation < ActiveRecord::Migration[5.1]
  def change
    create_table :stations do |t|
      t.string :name
      t.integer :dock_count
      t.string :city
      t.datetime :installation_date
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
  end
end
