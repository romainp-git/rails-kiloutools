class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :load_products, only: [:index, :search]

  def index
  end

  def show
  end

  def search
    render :index
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    begin
      if @product.save
        flash[:notice] = "Product was successfully created"
        redirect_to @product
      else
        flash[:alert] = "Failed to create product"
        render :new
      end
    rescue => e
      log_error(e)
      flash[:alert] = "Failed to create product"
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
  end

  def update
    begin
      if @product.update(product_params)
        flash[:notice] = "Product was successfully updated"
        redirect_to @product
      else
        flash[:alert] = "Failed to update product"
        render :edit
      end
    rescue => e
      log_error(e)
      flash[:alert] = "Failed to update product"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    begin
      if @product.destroy
        flash[:notice] = "Product was successfully destroyed"
        redirect_to products_path
      else
        flash[:alert] = "Failed to delete product"
        redirect_to product_path(@product)
      end
    rescue => e
      log_error(e)
      flash[:alert] = "Failed to delete product"
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :state, :model, :photo_url, :price)
  end

  def search_params
    params.fetch(:search, {}).permit(:name, :address, :start_date, :end_date)
  end

  def set_product
    begin
      @product = Product.find(params[:id])
    rescue => e
      log_error(e)
      flash[:alert] = "Product not found"
      redirect_to products_path
    end
  end

  def load_products
    @search_params = search_params
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
      if search_params[:start_date].present? && search_params[:end_date].present?
        start_date = Date.parse(search_params[:start_date])
        end_date = Date.parse(search_params[:end_date])

        products = products.select do |product|
          product.bookings.none? do |booking|
            (booking.start_date <= end_date) && (booking.end_date >= start_date)
          end
        end
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
