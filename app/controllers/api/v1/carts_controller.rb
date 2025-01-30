class Api::V1::CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart

  def show
    cart = current_user.cart
    render json: cart, include: { cart_items: { include: :product } }
  end

  private

  def set_cart
    @cart = current_user.cart || current_user.create_cart!
  end
end
