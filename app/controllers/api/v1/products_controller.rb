class Api::V1::ProductsController < ApplicationController
  def index
    products = Product.all
    render json: products
  end

  def show
    render json: current_product
  end

  private

  def current_product
    @product = Product.find(params[:id])
  end
end
