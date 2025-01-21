class Product < ApplicationRecord
  validates :name, :description, :price, :stock_quantity, presence: true

  has_one_attached :product_picture
end
