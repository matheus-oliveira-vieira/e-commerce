class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, class_name: "CartItem", dependent: :destroy

  before_save :update_total_price
  after_save :update_total_price_if_needed

  private

  def update_total_price
    self.total_price = cart_items.includes(:product).sum { |cart_item| cart_item.product.price * cart_item.quantity }
  end

  def update_total_price_if_needed
    update_column(:total_price, cart_items.includes(:product).sum { |cart_item| cart_item.product.price * cart_item.quantity })
  end
end
