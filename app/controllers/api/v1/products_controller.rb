class Api::V1::ProductsController < ApplicationController
  def index
    @products = Product.all
    render json: products
  end

  # def create
  #   product = Product.create!(product_params)
  #   if product
  #     render json: product
  #   else
  #     render json: product.errors
  #   end
  # end

  def show
    # render json: @product
    render json: current_product
  end

  # def destroy
  #   @product&.destroy
  #   render json: { message: "Product deleted!" }
  # end

  private

  # def product_params
  #   params.permit(:name, :description, :price, :stock_quantity)
  # end

  def current_product
    @product = Product.find(params[:id])
  end
end
