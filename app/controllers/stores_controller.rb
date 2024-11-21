class StoresController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  def index
    @user = current_user
    @products = Product.where(user_id: @user)
    @bookings = Booking.joins(:product).where(products: { user_id: @user })
  end


  private

  def booking_params
    params.require(:booking).permit(:status)
  end
end
