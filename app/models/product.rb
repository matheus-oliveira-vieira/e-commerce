class Product < ApplicationRecord
  has_many :cart_items
  has_many :carts, through: :cart_items

  validates :name, :description, :price, presence: true

  has_one_attached :product_picture
end
