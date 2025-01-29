class Api::V1::CartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart

  def create
    product = Product.find(params[:product_id])
    item = @cart.cart_items.find_or_initialize_by(product: product)
    item.quantity += 1
    if item.save
      render json: @cart, include: { cart_items: { include: :product } }
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
end
