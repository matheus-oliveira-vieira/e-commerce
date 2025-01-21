class Api::V1::ProductsController < ApplicationController
  before_action :set_product, only: %i[show destroy]

  def index
    product = Product.all.order(created_at: :desc)
    render json: product
  end

  def create
    product = Product.create!(product_params)
    if product
      render json: product
    else
      render json: product.errors
    end
  end

  def show
    render json: @product
  end

  def destroy
    @product&.destroy
    render json: { message: 'Product deleted!' }
  end

  private

  def product_params
    params.permit(:name, :description, :price, :stock_quantity)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
