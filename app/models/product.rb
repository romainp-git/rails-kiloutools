class Product < ApplicationRecord
  belongs_to :brand
  belongs_to :categorie
  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'

  has_many :bookings
  has_many :customers, through: :bookings, source: :user
end
