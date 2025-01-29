class RemoveColumnsFromCartItems < ActiveRecord::Migration[8.0]
  def change
    remove_column :cart_items, :cart_id, :integer
    remove_column :cart_items, :product_id, :integer
  end
end
