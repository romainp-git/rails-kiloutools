class Product < ApplicationRecord
  STATES = ["New", "Like new", "Good", "Fair", "Poor"]

  belongs_to :brand
  belongs_to :category
  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'

  has_many :bookings
  has_many :customers

  has_one_attached :photo

  validates :name, :description, :state, :model, :price, presence: true
  validates :state, inclusion: { in: STATES, message: "%{value} isn't a valid state" }
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_user_id?

  def can_be_destroyed?
    bookings.empty?
  end

  def address
    owner.address
  end
end
