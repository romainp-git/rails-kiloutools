class Product < ApplicationRecord
  belongs_to :brand
  belongs_to :category
  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'

  has_many :bookings
  has_many :customers

  STATES = ["New", "Like new", "Good", "Fair", "Poor"]

  validates :name, :description, :state, :model, :photo_url, :price, presence: true
  validates :state, inclusion: { in: STATES, message: "%{value} isn't a valid state" }
  validates :photo_url, format: { with: /\A(http|https):\/\/[a-zA-Z0-9\-_]+(\.[a-zA-Z0-9\-_]+)+(:\d+)?(\/[^\s]*)?\z/i, message: "is invalid" }
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
