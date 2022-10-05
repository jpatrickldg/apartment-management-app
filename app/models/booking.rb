class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_many :invoices, dependent: :destroy
  has_many :payments, through: :invoices

  enum status: [ :active, :inactive ]

  before_create :set_due_date, :update_room_occupants
  before_update :deactivate_tenant_account
  before_update :set_room_occupants_once_inactive

  # validate :only_one_active_booking
  validate :stop_deactivation_if_invoice_is_unpaid
  validates :move_in_date, presence: true

  def set_processed_by(user_email)
    self.processed_by = user_email
    self.save!
  end

  def set_room_occupants_once_inactive
    return unless self.inactive?
    room = Room.find(self.room_id)
    if room.occupants_count > 0
      room.occupants_count -= 1
      room.save!
    end
  end
  
  def update_room_occupants
    room = Room.find(self.room_id)
    room.occupants_count += 1
    room.save!
  end

  def deactivate_tenant_account
    return unless self.inactive?
    tenant = User.find(self.user_id)
    tenant.inactive!
  end
  
  private

  def stop_deactivation_if_invoice_is_unpaid
    return unless self.inactive?

    unpaid_invoices = Invoice.where(booking_id: self.id).where(status: 'unpaid')
    if unpaid_invoices.any?
      errors.add("Booking has an unpaid invoice")
    end
  end

  # def only_one_active_booking
  #   return unless self.active?

  #   bookings = Booking.active
  #   if persisted?
  #     bookings = bookings.where('id != ?', id)
  #   end
  #   if bookings.exists?
  #     errors.add(:status, "Tenant currently has an active booking")
  #   end
  # end

  def set_due_date
    self.due_date = self.move_in_date + 1.month
  end
end
