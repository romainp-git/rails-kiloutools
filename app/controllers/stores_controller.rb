class StoresController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  def index
    @user = current_user
    @products = Product.where(user_id: @user)
  end
end
