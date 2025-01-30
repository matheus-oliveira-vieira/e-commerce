class AddTotalPriceToCarts < ActiveRecord::Migration[8.0]
  def change
    add_column :carts, :total_price, :decimal, default: 0.0
  end
end
