class RemovePriceFromCartItems < ActiveRecord::Migration[8.0]
  def change
    remove_column :cart_items, :price, :decimal
  end
end
