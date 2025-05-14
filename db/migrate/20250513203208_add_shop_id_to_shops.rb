class AddShopIdToShops < ActiveRecord::Migration[8.0]
  def change
    add_column :shops, :identifier, :string
  end
end
