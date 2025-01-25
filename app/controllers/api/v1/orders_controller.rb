class Api::V1::OrdersController < ApplicationController
  before_action :authenticate_user!, only: %i[index show new create]
  before_action :cart_is_empty, only: %i[new create]

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
    @cart = @current_cart
  end

  def create
    @order = Order.new(order_params)
    @order.update(user_id: @current_user.id)
    add_line_items_to_order
    @order.save!
    reset_sessions_cart
    redirect_to api_v1_orders_path
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to api_v1_orders_path
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to api_v1_orders_path
  end

  def cart_is_empty
    return unless @current_cart.line_items.empty?

    store_location
    flash[:danger] = "You cart is empty!"
    redirect_to @current_cart
  end

  private

  def add_line_items_to_order
    @current_cart.line_items.each do |item|
      item.cart_id = nil
      item.order_id = @order.id
      item.save
      @order.line_items << item
    end
  end

  def reset_sessions_cart
    Cart.destroy(session[:cart_id])
    session[:cart_id] = nil
  end

  def order_params
    params.permit(:user_id)
  end
end
