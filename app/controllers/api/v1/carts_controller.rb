class Api::V1::CartsController < ApplicationController
  # before_action :authenticate_user!, only: [ :add_to_cart ]

  # def new
  #   return head :forbidden if current_user.cart.present?

  #   @cart = current_user.build_cart
  #   if @cart.save!
  #     # render json: { message: "Successfully" }
  #     redirect_to api_v1_cart_path(current_user.cart)
  #   else
  #     render json: { errors: @cart.errors.full_messages }, status: :unprocessable_entity
  #   end
  # end

  # def show
  #   @cart = current_user.cart || current_user.build_cart
  #   @product = Product.find_by(id: params[:product_id])
  #   @cart_items = @cart.cart_items

  #   if @cart.cart_items.empty?
  #     redirect_to root_path
  #   end
  # end

  # def add_to_cart
  #   @product = Product.find_by(id: params[:product_id])
  #   return head :forbidden if @product.empty?

  #   if @product
  #     @cart = current_user.cart || current_user.build_cart
  #     cart_item = @cart.cart_items.find_or_initialize_by(product: @product)
  #     cart_item.quantity ||= 1
  #     cart_item.assign_attributes(price: @product.price)
  #     cart_item.save!
  #     # render json: { message: "Successfully" } if cart_item.save!
  #   end
  #   redirect_to api_v1_cart_path
  # end

  # # def update_quantity
  # #   return head :forbidden unless current_user.cart.present?

  # #   @cart = current_user.cart
  # #   @product = Product.find_by(id: params[:product_id])
  # #   @cart_item = @cart.cart_items.find_or_initialize_by(product: @product)
  # #   new_quantity = @cart_item.quantity + 1

  # #   return render json: { message: "Update quantity successfully" } if @cart_item.update(quantity: new_quantity)

  # #   render json: { errors: "Error in update quantity" }, status: :unprocessable_entity
  # # end
  # # def downgrade_quantity
  # #   return head :forbidden unless current_user.cart.present?

  # #   @cart = current_user.cart
  # #   @product = Product.find_by(id: params[:product_id])
  # #   @cart_item = @cart.cart_items.find_or_initialize_by(product: @product)

  # #   if @cart_item && @cart_item.quantity > 1
  # #     new_quantity = @cart_item.quantity - 1

  # #     if @cart_item && @cart_item.quantity > 1
  # #       new_quantity = @cart_item.quantity - 1
  # #       return render json: { message: "Update quantity successfully" } if @cart_item.update(quantity: new_quantity)

  # #       render json: { errors: "Error in update quantity" }, status: :unprocessable_entity
  # #     else
  # #       render json: { errors: "Error in update quantity" }, status: :unprocessable_entity
  # #     end
  # #   end
  # # end

  # def remove_product_from_cart
  #   return head :forbidden unless current_user.cart.present?

  #   @cart = current_user.cart
  #   @product = Product.find_by(id: params[:product_id])
  #   @cart_item = @cart.cart_items.find_by(product: @product)

  #   if @cart_item
  #     @cart_item.destroy
  #     #create_activity_log(:removed_from_cart, @cart_item, details: { message: 'Product has been removed from cart'})
  #     # action cable
  #     # ActionCable.server.broadcast("cart_channel_#{current_user.id}", { action: 'product_removed', product_id: @product.id })
  #     # Rails.logger.info("Broadcasted product_removed to CartChannel")

  #     if @cart.cart_items.empty?
  #       redirect_to root_path
  #     else
  #       redirect_to api_v1_cart_path(current_user.cart), notice: 'Your product has benn removed from your cart'
  #     end
  #   end

  #   # render json: { message: "Successfully" } if @cart.destroy
  # end
  before_action :set_cart
  before_action :authenticate_user!

  def show
    cart = current_user.cart
    render json: cart, include: { cart_items: { include: :product } }
  end

  private

  def set_cart
    @cart = current_user.cart || current_user.create_cart
  end
end
