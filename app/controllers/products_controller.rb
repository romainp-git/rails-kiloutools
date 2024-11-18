class ProductsController < ApplicationController
  def index
    @products = filter_products(params[:search])
    @markers = set_markers(@products)
  end

  def show
    @product = Product.find(params[:id])
  end

  def search
    @products = filter_products(params[:search])
    @markers = set_markers(@products)
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

  def set_markers(products)
    products.map do |product|
      {
        lat: product.latitude,
        lng: product.longitude,
      }
    end
  end
end
