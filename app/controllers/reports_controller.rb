class ReportsController < ApplicationController
  before_action :authenticate_user!

  def index
    current_date = Date.today
    
    # occupancy 
    total_occupancy_count = Room.sum(:occupants_count)
    total_capacity_count = Room.sum(:capacity_count)
    available = total_capacity_count - total_occupancy_count
    branch_counts = Branch.select(:address, :branch_type).joins(:rooms).group(:address, :branch_type).sum('rooms.occupants_count').transform_values(&:to_i)
    branch_capacity = Branch.select(:address).joins(:rooms).group(:address).sum('rooms.capacity_count').transform_values(&:to_i)

    # inquiries
    inquiries_count = Inquiry.all.count
    open_inquiry_count = Inquiry.where(status: "open").count
    closed_inquiry_count = Inquiry.where(status: "closed").count
    on_going_inquiry_count = Inquiry.where(status: "on_going").count
    contract_signed_count = Inquiry.where(contract_signed: true).count
    inquiry_male_count = Inquiry.where(gender: 'male').count
    inquiry_female_count = Inquiry.where(gender: 'female').count
    inquiry_student_count = Inquiry.where(occupation: 'student').count
    inquiry_reviewee_count = Inquiry.where(occupation: 'reviewee').count
    inquiry_recto_count = Inquiry.where(location_preference: 'Recto').count
    inquiry_espana_count = Inquiry.where(location_preference: 'Espana').count
    inquiry_tacio_count = Inquiry.where(location_preference: 'Tacio').count
    inquiry_vicente_cruz_count = Inquiry.where(location_preference: 'Vicente Cruz').count
    inquiry_bedspace_count = Inquiry.where(room_type: 'bedspace').count
    inquiry_condo_count = Inquiry.where(room_type: 'condo fully-furnished').count
    inquiry_condo_empty_count = Inquiry.where(room_type: 'condo empty').count
    inquiry_studio_count = Inquiry.where(room_type: 'studio').count
    inquiry_boarding_house_count = Inquiry.where(room_type: 'boarding house').count

    #financial
    total_expenses = Expense.all.sum('expenses.amount')
    total_unpaid_invoices = Invoice.where(status: 'unpaid').sum('invoices.total_amount')
    total_payments_amount = Payment.where(status: 'approved').sum('payments.amount')
    gross_earnings = (total_payments_amount + total_unpaid_invoices) - total_expenses

    @generated_report = {
      current_date: current_date,

      total_occupancy_count: total_occupancy_count,
      total_capacity_count: total_capacity_count,
      available: available,
      branch_counts: branch_counts,
      branch_capacity: branch_capacity,

      inquiries_count: inquiries_count,
      open_inquiry_count: open_inquiry_count,
      closed_inquiry_count: closed_inquiry_count,
      on_going_inquiry_count: on_going_inquiry_count,
      contract_signed_count: contract_signed_count,
      inquiry_male_count: inquiry_male_count,
      inquiry_female_count: inquiry_female_count,
      inquiry_student_count: inquiry_student_count,
      inquiry_reviewee_count: inquiry_reviewee_count,
      inquiry_recto_count: inquiry_recto_count,
      inquiry_espana_count: inquiry_espana_count,
      inquiry_tacio_count: inquiry_tacio_count,
      inquiry_vicente_cruz_count: inquiry_vicente_cruz_count,
      inquiry_bedspace_count: inquiry_bedspace_count,
      inquiry_condo_count: inquiry_bedspace_count,
      inquiry_condo_empty_count: inquiry_condo_empty_count,
      inquiry_studio_count: inquiry_studio_count,
      inquiry_boarding_house_count: inquiry_boarding_house_count,

      total_expenses: total_expenses,
      total_unpaid_invoices: total_unpaid_invoices,
      total_payments_amount: total_payments_amount,
      gross_earnings: gross_earnings
    }
    
  end

  def yearly
    # Logic for generating yearly report
  end

  def monthly
    # Logic for generating monthly report

  end

  def custom
    if params[:start_date] && params[:end_date] && params[:model]
      start_date = parse_date(params[:start_date])
      end_date = parse_date(params[:end_date])
      @model = params[:model]

      if start_date && end_date
        case @model
        when 'bookings'
          @records = Booking.where(created_at: start_date..end_date)
          @record_count = @records.count
        when 'payments'
          @records = Payment.where(created_at: start_date..end_date)
          @record_count = @records.count
        when 'inquiries'
          @records = Inquiry.where(created_at: start_date..end_date)
          @record_count = @records.count
        when 'earnings'
          @total_expenses = Expense.where(created_at: start_date..end_date).sum(:amount)
          @total_payments =Payment.where(status: 'approved', created_at: start_date..end_date).sum(:amount)
          @earnings = @total_payments - @total_expenses
        else
          # Handle invalid model selection
          redirect_to reports_path, alert: 'Invalid model selection.'
          return
        end

        @generated_report = {
          start_date: start_date,
          end_date: end_date,
          model: @model,
          record_count: @record_count,
          total_expenses: @total_expenses,
          total_payments: @total_payments,
          earnings: @earnings
        }
      else
        # Handle invalid date inputs
        redirect_to reports_path, alert: 'Invalid date inputs.'
        return
      end
    end
  end

  private

  def parse_date(date_string)
    Date.strptime(date_string, "%Y-%m-%d") rescue nil
  end
end
