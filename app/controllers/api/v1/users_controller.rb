class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!
  def index
  end

  def create
  end

  def show
  end

  def destroy
  end

  def current
    if user_signed_in?
      render json: current_user
    else
      render json: {}
    end
  end
end
