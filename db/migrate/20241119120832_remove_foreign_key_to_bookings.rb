class RemoveForeignKeyToBookings < ActiveRecord::Migration[7.1]
  def change
    remove_reference :products, :user
    remove_reference :bookings, :user
  end
end
