class Api::V1::CartsController < ApplicationController
  before_action :authenticate_user!, only: [ :add_to_cart ]

  def create
    return head :forbidden unless current_user.cart.present?

    @cart = Cart.new(current_user)
    render json: { message: "Successfully" } if @cart.save!
  end
  def show
    @cart = current_user.cart || Cart.new(current_user)
    @product = Product.find_by(id: params[:product_id])

    return head :forbidden if @cart.cart_items.empty?

    @cart_items = @cart.cart_items

    render json: @cart_items, status: :ok
  end

  def add_to_cart
    @product = Product.find_by(id: params[:product_id])
    return head :forbidden if @product.empty?

    if @product
      @cart = current_user.cart || Cart.new(current_user)
      cart_item = @cart.cart_items.find_or_initialize_by(product: @product)
      cart_item.quantity ||= 1
      cart_item.assign_attributes(price: @product.price)

      render json: { message: "Successfully" } if cart_item.save!
    end
  end
  def update_quantity
    return head :forbidden unless current_user.cart.present?

    @cart = current_user.cart
    @product = Product.find_by(id: params[:product_id])
    @cart_item = @cart.cart_items.find_or_initialize_by(product: @product)
    new_quantity = @cart_item.quantity + 1

    return render json: { message: "Update quantity successfully" } if @cart_item.update(quantity: new_quantity)

    render json: { errors: "Error in update quantity" }, status: :unprocessable_entity
  end
  def downgrade_quantity
    return head :forbidden unless current_user.cart.present?

    @cart = current_user.cart
    @product = Product.find_by(id: params[:product_id])
    @cart_item = @cart.cart_items.find_or_initialize_by(product: @product)

    if @cart_item && @cart_item.quantity > 1
      new_quantity = @cart_item.quantity - 1

      if @cart_item && @cart_item.quantity > 1
        new_quantity = @cart_item.quantity - 1
        return render json: { message: "Update quantity successfully" } if @cart_item.update(quantity: new_quantity)

        render json: { errors: "Error in update quantity" }, status: :unprocessable_entity
      else
        render json: { errors: "Error in update quantity" }, status: :unprocessable_entity
      end
    end
  end
  def remove_product_from_cart
    return head :forbidden unless current_user.cart.present?

    @cart = current_user.cart
    @product = Product.find_by(id: params[:product_id])
    @cart_item = @cart.cart_items.find_by(product: @product)

    render json: { message: "Successfully" } if @cart.destroy
  end
end
