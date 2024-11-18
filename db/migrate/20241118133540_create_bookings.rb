class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.date :start_date
      t.date :end_date
      t.string :status
      t.float :amount
      t.references :products, null: false, foreign_key: true

      t.timestamps
    end
  end
end
