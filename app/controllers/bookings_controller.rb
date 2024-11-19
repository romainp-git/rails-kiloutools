class BookingsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :show, :index, :destroy]
  def new
    @booking = Booking.new()
    @product = Product.find(params[:product_id])
    @price = @product.price
  end

  def create
    @booking.user = current_user
    @booking = Booking.new(booking_params.merge(user_id: current_user))
    if @booking.save
      redirect_to booking_path(@booking)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @booking = Booking.find(params[:booking_id])
  end

  def index
    @user = current_user
    @bookings = Booking.where(user_id: @user)
  end

  def destroy
    @booking = Booking.find(params[:booking_id])
    @booking.destroy
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :amount, :product_id)
  end
end
