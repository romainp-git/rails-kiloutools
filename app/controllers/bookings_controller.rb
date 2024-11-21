class BookingsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :show, :index, :destroy, :update]
  skip_before_action :verify_authenticity_token, only: [:update]
  def new
    @booking = Booking.new()
    @product = Product.find(params[:product_id])
    @price = @product.price
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @product = Product.find(params[:product_id])
    @booking.product = @product
    @booking.status = "Pending"

    if @booking.save
      redirect_to booking_path(@booking)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def index
    @user = current_user
    @bookings = Booking.where(user_id: @user)
  end

  def destroy
    @booking = Booking.find(params[:booking_id])
    @booking.destroy
  end

  def update
    @booking = Booking.find(params[:id])
    if @booking.update(strong_params)
      render json: @booking, status: :ok
    else
      render json: @booking.errors, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :amount, :product_id)
  end

  def strong_params
    params.require(:booking).permit(:status)
  end
end
