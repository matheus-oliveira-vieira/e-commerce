class Api::V1::CartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart

  def create
    product = Product.find(params[:product_id])
    item = @cart.cart_items.find_or_initialize_by(product: product)
    item.quantity = (item.quantity || 0) + 1
    if item.save
      # total_price = @cart.cart_items.includes(:product).sum { |cart_item| cart_item.product.price * cart_item.quantity }
      # update_cart_price!
      render json: {
      id: @cart.id,
      cart_items: @cart.cart_items.map do |cart_item|
        {
          id: cart_item.id,
          quantity: cart_item.quantity,
          product: {
            id: cart_item.product.id,
            name: cart_item.product.name,
            price: cart_item.product.price,
            product_picture_url: cart_item.product.product_picture.attached? ? Rails.application.routes.url_helpers.rails_blob_url(cart_item.product.product_picture, only_path: true) : nil
          }
        }
      end
    }.merge(price: @cart.total_price)
    else
      render json: { error: "Erro ao adicionar item" }, status: :unprocessable_entity
    end
  end

  def update
    item = @cart.cart_items.find(params[:id])
    if item.update(quantity: params[:quantity])
      render json: @cart, include: { cart_items: { include: :product } }
    else
      render json: { error: "Erro ao atualizar item" }, status: :unprocessable_entity
    end
  end

  def destroy
    item = @cart.cart_items.find(params[:id])
    item.destroy
    render json: @cart, include: { cart_items: { include: :product } }
  end

  private

  def set_cart
    @cart = current_user.cart || current_user.create_cart
  end

  # def update_cart_price!
  #   total_price = @cart.cart_items.joins(:product).sum("cart_items.quantity * products.price")
  #   @cart.update(price: total_price || 0)
  # end
end
