class Cart < ApplicationRecord
  belongs_to :user

  has_many :cart_items, class_name: "CartItem", dependent: :destroy

  def total_price
    cart_items.joins(:product).sum("cart_items.quantity * products.price")
  end
end
