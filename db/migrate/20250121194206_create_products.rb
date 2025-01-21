class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.decimal :price, null: false
      t.integer :stock_quantity, null: false

      t.timestamps
    end
  end
end
