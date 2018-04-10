class CreateAccessories < ActiveRecord::Migration[5.1]
  def change
    create_table :accessories do |t|
      t.string :title
      t.text :description
      t.decimal :price, precision: 9, scale: 2
      t.text :image_url
      t.timestamps
    end
  end
end
