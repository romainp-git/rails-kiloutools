class Product < ApplicationRecord
  belongs_to :brand
  belongs_to :category
  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'
  
  has_many :bookings
  has_many :customers

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_user_id?

  def address
    owner.address
  end
end
