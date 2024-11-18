class AddReferences < ActiveRecord::Migration[7.1]
  def change
    add_reference(:products, :user)
    add_reference(:bookings, :user)
  end
end
