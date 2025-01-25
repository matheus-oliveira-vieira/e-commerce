class Api::V1::CartsController < ApplicationController
  before_action :authenticate_user!, only: [ :add_to_cart ]
  # new cart
  def new
    # if the user have one cart
    if current_user.cart.present?
      redirect_to api_v1_cart_path(current_user.cart)
    else
      # make a new cart
      @cart = current_user.build_cart
      # if make correcly the cart

      if @cart.save
        render json: { message: "Successfully" }
        redirect_to api_v1_cart_path(current_user.cart)
      end
    end
  end

  def show
    @cart = current_user.cart || current_user.build_cart
    @product = Product.find_by(id: params[:product_id])
    @cart_items = @cart.cart_items

    if @cart.cart_items.empty?
      redirect_to root_path
    end
  end
  # add product on cart
  def add_to_cart
    @product = Product.find_by(id: params[:product_id])

    if @product
      @cart = current_user.cart || current_user.build_cart
      cart_item = @cart.cart_items.find_or_initialize_by(product: @product)
      cart_item.quantity ||= 1
      cart_item.assign_attributes(price: @product.price)
      cart_item.save!
    end
    redirect_to api_v1_cart_path
  end
  # +1 quantity
  def update_quantity
    @cart = current_user.cart
    @product = Product.find_by(id: params[:product_id])
    @cart_item = @cart.cart_items.find_or_initialize_by(product: @product)
    new_quantity = @cart_item.quantity + 1

    if @cart_item.update(quantity: new_quantity)
      render json: { message: "Update quantity successfully" }
      redirect_to api_v1_cart_path(@cart)
    else
      render json: { errors: "Error in update quantity" }, status: :unprocessable_entity
    end
  end
  # -1 quantity
  def downgrade_quantity
    @cart = current_user.cart
    @product = Product.find_by(id: params[:product_id])
    @cart_item = @cart.cart_items.find_or_initialize_by(product: @product)

    if @cart_item && @cart_item.quantity > 1
      new_quantity = @cart_item.quantity - 1

      if @cart_item && @cart_item.quantity > 1
        new_quantity = @cart_item.quantity - 1
        if @cart_item.update(quantity: new_quantity)
          render json: { message: "Update quantity successfully" }
          redirect_to api_v1_cart_path(@cart)
        else
          render json: { errors: "Error in update quantity" }, status: :unprocessable_entity
          redirect_to api_v1_cart_path(@cart)
        end
      else
        render json: { errors: "Error in update quantity" }, status: :unprocessable_entity
        redirect_to api_v1_cart_path(@cart)
      end
    end
  end
  # remove product from the cart
  def remove_product_from_cart
    @cart = current_user.cart
    @product = Product.find_by(id: params[:product_id])
    @cart_item = @cart.cart_items.find_by(product: @product)

    if @cart_item
      @cart_item.destroy
      if @cart.cart_items.empty?
        redirect_to root_path
      else
        redirect_to api_v1_cart_path(current_user.cart), notice: "Your product has benn removed from your cart"
      end
    else
        redirect_to @cart, notice: "Not possible to remove your product, try again."
    end
  end
end
