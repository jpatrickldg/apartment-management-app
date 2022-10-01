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

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :birthdate, presence: true
  validates :gender, presence: true
  validates :contact_no, presence: true, length: { is: 11 }
  validates :address, presence: true
  validates :role, presence: true
  

  def active_for_authentication?
    super && self.active?
  end

  # def inactive_message
  #   "Sorry, this account has been deactivated"
  # end
  
  

end
