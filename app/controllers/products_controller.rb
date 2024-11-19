class ProductsController < ApplicationController
  def index
    @products = filter_products(params[:search])
  end

  def show
    @product = Product.find(params[:id])
  end

  def search
<<<<<<< Updated upstream
    @products = filter_products(params[:search])
=======
>>>>>>> Stashed changes
    render :index
  end

  private

  def filter_products(search_params)
    products = Product.all
    if search_params.present?
      if search_params[:address].present?
        products = products.near(search_params[:address], 10)
      end
      if search_params[:name].present?
        products = products.where("products.name ILIKE ?", "%#{search_params[:name]}%")
      end
    end
    return products
  end
end
