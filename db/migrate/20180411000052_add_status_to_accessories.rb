class AddStatusToAccessories < ActiveRecord::Migration[5.1]
  def change
    add_column :accessories, :status, :integer
  end
end
