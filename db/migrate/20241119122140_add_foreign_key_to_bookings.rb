class AddForeignKeyToBookings < ActiveRecord::Migration[7.1]
  def change
    add_reference :products, :user, foreign_key: true
    add_reference :bookings, :user, foreign_key: true
  end
end
