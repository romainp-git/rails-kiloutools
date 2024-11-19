class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :load_products, only: [:index, :search]

  def index
  end

  def show
    @count_products_per_owner = count_products_per_owner
    @place_name = find_place_name

    @booking = Booking.new()
    @price = @product.price
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

  def find_place_name
    current_product = Product.find(params[:id])
    results = Geocoder.search(current_product.owner.address)
    if results.present?
      place_name = results.first.data["place_name"]
    else
      place_name = "No valid address"
    end
    return place_name
  end

  def count_products_per_owner
    current_product = Product.find(params[:id])
    return Product.where(user_id: current_product[:user_id]).count
  end

end
