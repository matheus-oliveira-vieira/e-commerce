class Api::V1::OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.includes(:order_items, :products)
    render json: @orders, include: { order_items: { include: :product } }
  end

  def create
    cart = current_user.cart
    if cart.cart_items.empty?
      return render json: { error: "Carrinho está vazio" }, status: :unprocessable_entity
    end

    order = current_user.orders.create(total_price: cart.total_price)

    cart.cart_items.each do |item|
      order.order_items.create(product: item.product, quantity: item.quantity)
    end

    cart.cart_items.destroy_all

    render json: order, status: :created
  end
end
