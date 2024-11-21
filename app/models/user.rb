class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :products
  has_many :bookings
  has_many :customers, through: :bookings, source: :user

  has_one_attached :photo

  validates :description, length: { maximum: 250 }
end
