class ProductsController < ApplicationController
  before_action :load_products, only: [:index, :search]

  def index
  end

  def show
    @product = Product.find(params[:id])
  end

  def search
    render "products/index"
  end

  private

  def load_products
    @products = filter_products(params[:search])
    @markers = set_markers(@products)
  end

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

    products
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
