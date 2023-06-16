class ReportsController < ApplicationController
  before_action :authenticate_user!

  def index

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
