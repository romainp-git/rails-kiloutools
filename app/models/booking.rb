class Booking < ApplicationRecord
  belongs_to :product
  belongs_to :user
  has_one :owner, through: :products, source: :user

  STATUS = ["Pending", "Accepted", "Refused"]
  # STATUS = ["En attente", "Accepté", "Refusé"]

end
