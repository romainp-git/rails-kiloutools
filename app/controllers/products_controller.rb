class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:summary, :update_active]
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :load_products, only: [:index, :search]
  skip_before_action :verify_authenticity_token, only: [:update_active]

  def index
    @bookings_dates = {}.to_json
  end

  def show
    @booking = Booking.new()
    @start_date = Date.strptime(session[:start_date], "%d-%m-%Y") if session[:start_date]
    @end_date = Date.strptime(session[:end_date], "%d-%m-%Y") if session[:end_date]

    @count_products_per_owner = count_products_per_owner
    @place_name = find_place_name
    @markers = [{lat: @product.latitude, lng: @product.longitude}]

    @bookings = @product.bookings.where(status: ['Pending', 'Accepted'])
    @bookings_dates = @bookings.map do |booking|
      {
        from: booking.start_date,
        to: booking.end_date
      }
    end.to_json
  end

  def search
    render :index
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.user_id = current_user.id

    begin
      if @product.save
        # ajout des photos issues du submit new
        @product.photos.attach(params[:product][:photos])

        # flash[:notice] = "Product was successfully created"
        redirect_to product_path(@product)
      else
        # flash[:alert] = "Failed to create product"
        render :new, status: :unprocessable_entity
      end
    rescue => e
      Rails.logger.error("Error creating product: #{e}")
      Rails.logger.debug @product.inspect
      # flash[:alert] = "Failed to create product"
      redirect_back(fallback_location: root_path)
      # render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    begin
      if @product.update(product_params)
        # ajout des photos issues du submit edit
        @product.photos.attach(params[:product][:photos])
        # flash[:notice] = "Product was successfully updated"
        redirect_to product_path(@product)
      else
        # flash[:alert] = "Failed to update product"
        render :edit
      end
    rescue => e
      Rails.logger.error("Error creating product: #{e}")
      Rails.logger.debug @product.inspect
      # flash[:alert] = "Failed to update product"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy_photo
    @product = Product.find(params[:id])
    @photo = ActiveStorage::Attachment.find(params[:photo_id])

    @photo.purge # Supprime la photo du stockage
    redirect_to edit_product_path(@product), notice: "Photo supprimée avec succès."
  end

  def add_photos
    @product = Product.find(params[:id])
    begin
      if @product.update(product_params)
        # ajout des photos issues du submit edit
        @product.photos.attach(params[:product][:photos])
        # flash[:notice] = "Product was successfully updated"
        redirect_to edit_product_path(@product), notice: "Photo(s) ajoutée(s) avec succès."
      else
        # flash[:alert] = "Failed to update product"
        render :edit
      end
    rescue => e
      Rails.logger.error("Error creating product: #{e}")
      Rails.logger.debug @product.inspect
      # flash[:alert] = "Failed to update product"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    begin
      if @product.destroy
        # flash[:notice] = "Product was successfully destroyed"
        redirect_to products_path
      else
        # flash[:alert] = "Failed to delete product"
        redirect_to product_path(@product)
      end
    rescue => e
      # log_error(e)
      Rails.logger.error("Error creating product: #{e}")
      Rails.logger.debug @product.inspect
      # flash[:alert] = "Failed to delete product"
      redirect_back(fallback_location: root_path)
    end
  end

  def summary
    @user = current_user
    @products = Product.where(user_id: @user)
  end

  def update_active
    @product = Product.find(params[:id])
    active_status = params[:active]
    if @product.update(active: active_status)
      render json: { success: true, active: @product.active }
    else
      render json: { success: false, error: 'Erreur de mise à jour' }, status: 400
    end
  end

  private

  def product_params
    # Les photos ne sont plus dans le permit car ça ne fonctionne pas
    # pour la gestion des ajouts ou suppression unitaires
    # La construction du tableau photos se fait dans update et save
    params.require(:product).permit(:name, :description, :state, :model, :price, :category_id, :brand_id)
  end

  def search_params
    params.fetch(:search, {}).permit(:name, :address, :start_date, :end_date)
  end

  def set_product
    begin
      @product = Product.find(params[:id])
    rescue => e
      # log_error(e)
      Rails.logger.error("Error creating product: #{e}")
      Rails.logger.debug @product.inspect
      # flash[:alert] = "Product not found"
      redirect_to products_path
    end
  end

  def load_products
    @search_params = search_params || {}
    @products = filter_products(params[:search])
    @markers = set_markers(@products)

    session[:start_date] = params[:search][:start_date] if params[:search].present? && params[:search][:start_date].present?
    session[:end_date] = params[:search][:end_date] if params[:search].present? && params[:search][:end_date].present?
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

    products = products.select { |product| product.active }
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
    results = Geocoder.search(@product.owner.address)
    if results.present? && results.first.data["address"]
      results.first.city || "Inconnu"
    else
      "Aucune information disponible"
    end
  end

  def count_products_per_owner
    return Product.where(user_id: @product [:user_id]).count
  end

end
