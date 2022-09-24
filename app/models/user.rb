class User < ApplicationRecord
  has_many :concerns 
  has_many :bookings
  has_many :rooms, through: :bookings
  has_many :invoices, through: :bookings
  has_many :payments, through: :invoices
  has_one_attached :avatar
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable
  
  enum status: [ :active, :inactive ]
  enum role: [ :tenant, :receptionist, :cashier, :maintenance, :owner, :admin ]
  

  def active_for_authentication?
    super && self.active?
  end

  def inactive_message
    "Sorry, this account has been deactivated"
  end
  
  

end
