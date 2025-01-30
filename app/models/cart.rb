class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, class_name: "CartItem", dependent: :destroy

  before_save :update_total_price

  private

  def update_total_price
    self.total_price = cart_items.includes(:product).sum { |cart_item| cart_item.product.price * cart_item.quantity }
  end
end
