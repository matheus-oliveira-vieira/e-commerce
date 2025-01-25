class Api::V1::ProductsController < ApplicationController
  def index
    render json: Product.all, status: :ok
  end
  def show
    render json: current_product, status: :ok
  end

  private

  def current_product
    @product = Product.find(params[:id])
  end
end
