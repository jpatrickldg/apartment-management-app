class User < ApplicationRecord
  has_many :concerns 
  has_many :bookings
  has_one :room, through: :booking
  has_one_attached :avatar
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable
  
  enum status: [ :active, :inactive ]
  enum role: [ :tenant, :receptionist, :cashier, :maintenance, :owner, :admin ]

end
