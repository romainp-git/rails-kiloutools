class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # INDEX + SHOW ========================
  def index
    @products = filter_products(params[:search])
  end

  def show
    @fTitle = "View #{@product.name} (#{@product.id})"
  end

  def search
    @products = filter_products(params[:search])
    render :index
  end

  # NEW + CREATE ========================
  def new
    @product = Product.new
    @fTitle = "Create a new product"
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

  # EDIT + UPDATE ========================
  def edit
    @fTitle = "Modify #{@product.name} (#{@product.id})"
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

  # DESTROY ========================
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

  # =================================
  private

  def product_params
    params.require(:product).permit(:name, :description, :state, :model, :photo_url, :price)
  end

  def set_product
    # Si l'id demandé n'existe pas alors retour sur index et affichage message alert
    begin
      @product = Product.find(params[:id])
    rescue => e
      log_error(e)
      flash[:alert] = "Product not found"
      redirect_to products_path
    end
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
    return products
  end
end
