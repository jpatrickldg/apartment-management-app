class User < ApplicationRecord
  has_many :concerns, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :rooms, through: :bookings
  has_many :contracts, through: :bookings
  has_many :invoices, through: :bookings
  has_many :payments, through: :invoices
  has_many :comments, dependent: :destroy
  has_one_attached :avatar
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable
  
  enum status: [ :active, :inactive ]
  enum role: [ :tenant, :receptionist, :cashier, :maintenance, :owner, :admin ]

  before_validation :format_contact_no

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :birthdate, presence: true
  validates :gender, presence: true
  validates :contact_no, presence: true, length: { is: 13 }
  validates :address, presence: true
  validates :role, presence: true

  def format_contact_no
    return if contact_no.blank?

    self.contact_no = "+63" + contact_no[1..-1]
  end
  

  def active_for_authentication?
    super && self.active?
  end

  # def inactive_message
  #   "Sorry, this account has been deactivated"
  # end
  
  

end
