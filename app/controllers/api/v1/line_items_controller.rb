class Api::V1::LineItemsController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy add_quantity
                                              reduce_quantity]

  def create
    # Find associated product and current cart
    chosen_product = Product.find(params[:product_id])
    add_items_to_cart(chosen_product)
    if @line_item.save!
      render json: { message: "Successfully" }
      # redirect_to cart_path # aqui
      redirect_to @current_cart
    else
      render json: { errors: "Error adding product" }, status: :unprocessable_entity
    end
  end

  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy
    redirect_to root_path
  end

  def add_quantity
    @line_item = LineItem.find(params[:id])
    @line_item.quantity += 1
    @line_item.save
    # redirect_to cart_path # aqui
    redirect_to @current_cart
  end

  def reduce_quantity
    @line_item = LineItem.find(params[:id])
    if @line_item.quantity > 1
      @line_item.quantity -= 1
      @line_item.save
      # redirect_to cart_path # aqui
      redirect_to @current_cart
    elsif @line_item.quantity == 1
      destroy
    end
  end

  private

  def add_items_to_cart(chosen_product)
    # If cart already has this product then find the relevant line_item
    # and iterate quantity otherwise create a new line_item for this product
    if @current_cart.products.include?(chosen_product)
      # Find the line_item with the chosen_product
      @line_item = @current_cart.line_items.find_by(product_id: chosen_product)
      # Iterate the line_item's quantity by one
      @line_item.quantity += 1
    else
      @line_item = LineItem.new
      @line_item.cart = @current_cart
      @line_item.product = chosen_product
      # @line_item.order = Order.first
      @line_item.quantity = 1
    end
  end
end
