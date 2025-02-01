class Api::V1::CartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def create
    product = Product.find(params[:product_id])
    item = @cart.cart_items.find_or_initialize_by(product: product)
    item.quantity = (item.quantity || 0) + 1

    if item.save
      total_price = @cart.cart_items.includes(:product).sum { |cart_item| cart_item.product.price * cart_item.quantity }
      @cart.update!(total_price: total_price)

      render json: {
        id: @cart.id,
        total_price: @cart.total_price,
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
      }
    else
      render json: { error: "Erro ao adicionar item" }, status: :unprocessable_entity
    end
  end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(quantity: params[:quantity])

    total_price = cart_item.cart.cart_items.includes(:product).sum { |item| item.product.price * item.quantity }
    cart_item.cart.update!(total_price: total_price)

    render json: {
      id: cart_item.cart.id,
      total_price: cart_item.cart.total_price,
      cart_items: cart_item.cart.cart_items.map do |cart_item|
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
    }
  end

  def destroy
    item = @cart.cart_items.find(params[:id])

    if item
      item.destroy
      total_price = @cart.cart_items.includes(:product).sum { |cart_item| cart_item.product.price * cart_item.quantity }
      @cart.update!(total_price: total_price)

      render json: { id: @cart.id, total_price: @cart.total_price, cart_items: @cart.cart_items }, status: :ok
    else
      render json: { error: "Item não encontrado" }, status: :not_found
    end
  end

  private

  def set_cart
    @cart = current_user.cart || current_user.create_cart
  end

  def record_not_found
    render json: { error: "Recurso não encontrado" }, status: :not_found
  end
end
