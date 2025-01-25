class Product < ApplicationRecord
  has_many :line_items, dependent: :destroy
  has_many :orders, through: :line_items

  validates :name, :description, :price, presence: true

  has_one_attached :product_picture
end
