class ReportsController < ApplicationController
  before_action :authenticate_user!

  def index
    current_date = Date.today
    
    # occupancy 
    branches = Branch.all
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

    #reviews
    review_count = Review.all.count
    maintenance_satisfaction_score = Review.average(:maintenance_satisfaction)
    responsiveness_effectiveness_score = Review.average(:responsiveness_effectiveness)
    common_area_cleanliness_score = Review.average(:common_area_cleanliness)
    lease_renewal_likelihood_score = Review.average(:lease_renewal_likelihood)
    recommend_apartment_score = Review.average(:recommend_apartment)
    overall_score = Review.average(:overall_score)

    #financial
    total_expenses = Expense.all.sum('expenses.amount')
    tenants_deposits = Deposit.joins(booking: :invoices).where(invoices: { status: Invoice.statuses[:paid], remarks: "Initial" }).sum(:total_amount)
    total_unpaid_invoices = Invoice.where(status: 'unpaid').sum('invoices.total_amount')
    total_payments_amount = Payment.where(status: 'approved').where(payment_mode: 'paymongo')
    .sum("payments.amount") * 0.975
    total_payments_amount += Payment.where(status: 'approved')
    .where.not(payment_mode: 'paymongo').sum("payments.amount")
    gross_earnings = (total_payments_amount + total_unpaid_invoices) - (total_expenses + tenants_deposits)

    @generated_report = {
      current_date: current_date,

      branches: branches,
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

      review_count: review_count,
      maintenance_satisfaction_score: maintenance_satisfaction_score,
      responsiveness_effectiveness_score: responsiveness_effectiveness_score,
      common_area_cleanliness_score: common_area_cleanliness_score,
      lease_renewal_likelihood_score: lease_renewal_likelihood_score,
      recommend_apartment_score: recommend_apartment_score,
      overall_score: overall_score,

      total_expenses: total_expenses,
      tenants_deposits: tenants_deposits,
      total_unpaid_invoices: total_unpaid_invoices,
      total_payments_amount: total_payments_amount,
      gross_earnings: gross_earnings
    }
    
  end

  def yearly
    # Logic for generating yearly report
    if params[:selected_date].present?
      year = params[:selected_date].to_i
      date = Date.new(year)
      start_date = date.beginning_of_year
      end_date = date.end_of_year

      if start_date && end_date
        end_date = end_date.end_of_day

        # occupancy 
        branches = Branch.all
        total_occupancy_count = Room.where(created_at: start_date..end_date).sum(:occupants_count)
        total_capacity_count = Room.sum(:capacity_count)
        available = total_capacity_count - total_occupancy_count
        branch_counts = Branch.where(created_at: start_date..end_date).select(:address, :branch_type).joins(:rooms).group(:address, :branch_type).sum('rooms.occupants_count').transform_values(&:to_i)
        branch_capacity = Branch.where(created_at: start_date..end_date).select(:address).joins(:rooms).group(:address).sum('rooms.capacity_count').transform_values(&:to_i)

        # inquiries
        inquiries_count = Inquiry.where(created_at: start_date..end_date).count
        open_inquiry_count = Inquiry.where(created_at: start_date..end_date, status: "open").count
        closed_inquiry_count = Inquiry.where(created_at: start_date..end_date, status: "closed").count
        on_going_inquiry_count = Inquiry.where(created_at: start_date..end_date, status: "on_going").count
        contract_signed_count = Inquiry.where(created_at: start_date..end_date, contract_signed: true).count
        inquiry_male_count = Inquiry.where(created_at: start_date..end_date, gender: 'male').count
        inquiry_female_count = Inquiry.where(created_at: start_date..end_date, gender: 'female').count
        inquiry_student_count = Inquiry.where(created_at: start_date..end_date, occupation: 'student').count
        inquiry_reviewee_count = Inquiry.where(created_at: start_date..end_date, occupation: 'reviewee').count
        inquiry_recto_count = Inquiry.where(created_at: start_date..end_date, location_preference: 'Recto').count
        inquiry_espana_count = Inquiry.where(created_at: start_date..end_date, location_preference: 'Espana').count
        inquiry_tacio_count = Inquiry.where(created_at: start_date..end_date, location_preference: 'Tacio').count
        inquiry_vicente_cruz_count = Inquiry.where(created_at: start_date..end_date, location_preference: 'Vicente Cruz').count
        inquiry_bedspace_count = Inquiry.where(created_at: start_date..end_date, room_type: 'bedspace').count
        inquiry_condo_count = Inquiry.where(created_at: start_date..end_date, room_type: 'condo fully-furnished').count
        inquiry_condo_empty_count = Inquiry.where(created_at: start_date..end_date, room_type: 'condo empty').count
        inquiry_studio_count = Inquiry.where(created_at: start_date..end_date, room_type: 'studio').count
        inquiry_boarding_house_count = Inquiry.where(created_at: start_date..end_date, room_type: 'boarding house').count

        #reviews
        review_count = Review.where(created_at: start_date..end_date).count
        maintenance_satisfaction_score = Review.where(created_at: start_date..end_date).average(:maintenance_satisfaction)
        responsiveness_effectiveness_score = Review.where(created_at: start_date..end_date).average(:responsiveness_effectiveness)
        common_area_cleanliness_score = Review.where(created_at: start_date..end_date).average(:common_area_cleanliness)
        lease_renewal_likelihood_score = Review.where(created_at: start_date..end_date).average(:lease_renewal_likelihood)
        recommend_apartment_score = Review.where(created_at: start_date..end_date).average(:recommend_apartment)
        overall_score = Review.where(created_at: start_date..end_date).average(:overall_score)

        #financial
        total_expenses = Expense.where(created_at: start_date..end_date).sum('expenses.amount')
        tenants_deposits = Deposit.joins(booking: :invoices).where(invoices: { status: Invoice.statuses[:paid], remarks: "Initial" }, created_at: start_date..end_date).sum(:total_amount)
        total_unpaid_invoices = Invoice.where(created_at: start_date..end_date, status: 'unpaid').sum('invoices.total_amount')
        total_payments_amount = Payment.where(created_at: start_date..end_date, status: 'approved').where(payment_mode: 'paymongo')
        .sum("payments.amount") * 0.975
        total_payments_amount += Payment.where(status: 'approved')
        .where.not(payment_mode: 'paymongo').sum("payments.amount")
        gross_earnings = (total_payments_amount + total_unpaid_invoices) - (total_expenses + tenants_deposits)

        @generated_report = {
          year: year,

          branches: branches,
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

          review_count: review_count,
          maintenance_satisfaction_score: maintenance_satisfaction_score,
          responsiveness_effectiveness_score: responsiveness_effectiveness_score,
          common_area_cleanliness_score: common_area_cleanliness_score,
          lease_renewal_likelihood_score: lease_renewal_likelihood_score,
          recommend_apartment_score: recommend_apartment_score,
          overall_score: overall_score,

          total_expenses: total_expenses,
          tenants_deposits: tenants_deposits,
          total_unpaid_invoices: total_unpaid_invoices,
          total_payments_amount: total_payments_amount,
          gross_earnings: gross_earnings
        }
      else
        redirect_to reports_path, alert: "Invalid date inputs."
      end
    end
  end

  def monthly
    # Logic for generating monthly report
    if params[:selected_date].present?
      date = parse_date_month(params[:selected_date])
      start_date = date.beginning_of_month
      end_date = date.end_of_month

      if start_date && end_date
        end_date = end_date.end_of_day

        # occupancy 
        branches = Branch.all
        total_occupancy_count = Room.where(created_at: start_date..end_date).sum(:occupants_count)
        total_capacity_count = Room.sum(:capacity_count)
        available = total_capacity_count - total_occupancy_count
        branch_counts = Branch.where(created_at: start_date..end_date).select(:address, :branch_type).joins(:rooms).group(:address, :branch_type).sum('rooms.occupants_count').transform_values(&:to_i)
        branch_capacity = Branch.where(created_at: start_date..end_date).select(:address).joins(:rooms).group(:address).sum('rooms.capacity_count').transform_values(&:to_i)

        # inquiries
        inquiries_count = Inquiry.where(created_at: start_date..end_date).count
        open_inquiry_count = Inquiry.where(created_at: start_date..end_date, status: "open").count
        closed_inquiry_count = Inquiry.where(created_at: start_date..end_date, status: "closed").count
        on_going_inquiry_count = Inquiry.where(created_at: start_date..end_date, status: "on_going").count
        contract_signed_count = Inquiry.where(created_at: start_date..end_date, contract_signed: true).count
        inquiry_male_count = Inquiry.where(created_at: start_date..end_date, gender: 'male').count
        inquiry_female_count = Inquiry.where(created_at: start_date..end_date, gender: 'female').count
        inquiry_student_count = Inquiry.where(created_at: start_date..end_date, occupation: 'student').count
        inquiry_reviewee_count = Inquiry.where(created_at: start_date..end_date, occupation: 'reviewee').count
        inquiry_recto_count = Inquiry.where(created_at: start_date..end_date, location_preference: 'Recto').count
        inquiry_espana_count = Inquiry.where(created_at: start_date..end_date, location_preference: 'Espana').count
        inquiry_tacio_count = Inquiry.where(created_at: start_date..end_date, location_preference: 'Tacio').count
        inquiry_vicente_cruz_count = Inquiry.where(created_at: start_date..end_date, location_preference: 'Vicente Cruz').count
        inquiry_bedspace_count = Inquiry.where(created_at: start_date..end_date, room_type: 'bedspace').count
        inquiry_condo_count = Inquiry.where(created_at: start_date..end_date, room_type: 'condo fully-furnished').count
        inquiry_condo_empty_count = Inquiry.where(created_at: start_date..end_date, room_type: 'condo empty').count
        inquiry_studio_count = Inquiry.where(created_at: start_date..end_date, room_type: 'studio').count
        inquiry_boarding_house_count = Inquiry.where(created_at: start_date..end_date, room_type: 'boarding house').count

        #reviews
        review_count = Review.where(created_at: start_date..end_date).count
        maintenance_satisfaction_score = Review.where(created_at: start_date..end_date).average(:maintenance_satisfaction)
        responsiveness_effectiveness_score = Review.where(created_at: start_date..end_date).average(:responsiveness_effectiveness)
        common_area_cleanliness_score = Review.where(created_at: start_date..end_date).average(:common_area_cleanliness)
        lease_renewal_likelihood_score = Review.where(created_at: start_date..end_date).average(:lease_renewal_likelihood)
        recommend_apartment_score = Review.where(created_at: start_date..end_date).average(:recommend_apartment)
        overall_score = Review.where(created_at: start_date..end_date).average(:overall_score)

        #financial
        total_expenses = Expense.where(created_at: start_date..end_date).sum('expenses.amount')
        tenants_deposits = Deposit.joins(booking: :invoices).where(invoices: { status: Invoice.statuses[:paid], remarks: "Initial" }, created_at: start_date..end_date).sum(:total_amount)
        total_unpaid_invoices = Invoice.where(created_at: start_date..end_date, status: 'unpaid').sum('invoices.total_amount')
        total_payments_amount = Payment.where(created_at: start_date..end_date, status: 'approved').where(payment_mode: 'paymongo')
        .sum("payments.amount") * 0.975
        total_payments_amount += Payment.where(status: 'approved')
        .where.not(payment_mode: 'paymongo').sum("payments.amount")
        gross_earnings = (total_payments_amount + total_unpaid_invoices) - (total_expenses + tenants_deposits)

        @generated_report = {
          selected_date: date,

          branches: branches,
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

          review_count: review_count,
          maintenance_satisfaction_score: maintenance_satisfaction_score,
          responsiveness_effectiveness_score: responsiveness_effectiveness_score,
          common_area_cleanliness_score: common_area_cleanliness_score,
          lease_renewal_likelihood_score: lease_renewal_likelihood_score,
          recommend_apartment_score: recommend_apartment_score,
          overall_score: overall_score,

          total_expenses: total_expenses,
          tenants_deposits: tenants_deposits,
          total_unpaid_invoices: total_unpaid_invoices,
          total_payments_amount: total_payments_amount,
          gross_earnings: gross_earnings
        }
      else
        redirect_to reports_path, alert: "Invalid date inputs."
      end
    end
  end

  def custom
    if params[:start_date] && params[:end_date]
      start_date = parse_date(params[:start_date])
      end_date = parse_date(params[:end_date])

      if start_date && end_date
        end_date = end_date.end_of_day
        # occupancy 
        branches = Branch.all
        total_occupancy_count = Room.where(created_at: start_date..end_date).sum(:occupants_count)
        total_capacity_count = Room.sum(:capacity_count)
        available = total_capacity_count - total_occupancy_count
        branch_counts = Branch.where(created_at: start_date..end_date).select(:address, :branch_type).joins(:rooms).group(:address, :branch_type).sum('rooms.occupants_count').transform_values(&:to_i)
        branch_capacity = Branch.where(created_at: start_date..end_date).select(:address).joins(:rooms).group(:address).sum('rooms.capacity_count').transform_values(&:to_i)

        # inquiries
        inquiries_count = Inquiry.where(created_at: start_date..end_date).count
        open_inquiry_count = Inquiry.where(created_at: start_date..end_date, status: "open").count
        closed_inquiry_count = Inquiry.where(created_at: start_date..end_date, status: "closed").count
        on_going_inquiry_count = Inquiry.where(created_at: start_date..end_date, status: "on_going").count
        contract_signed_count = Inquiry.where(created_at: start_date..end_date, contract_signed: true).count
        inquiry_male_count = Inquiry.where(created_at: start_date..end_date, gender: 'male').count
        inquiry_female_count = Inquiry.where(created_at: start_date..end_date, gender: 'female').count
        inquiry_student_count = Inquiry.where(created_at: start_date..end_date, occupation: 'student').count
        inquiry_reviewee_count = Inquiry.where(created_at: start_date..end_date, occupation: 'reviewee').count
        inquiry_recto_count = Inquiry.where(created_at: start_date..end_date, location_preference: 'Recto').count
        inquiry_espana_count = Inquiry.where(created_at: start_date..end_date, location_preference: 'Espana').count
        inquiry_tacio_count = Inquiry.where(created_at: start_date..end_date, location_preference: 'Tacio').count
        inquiry_vicente_cruz_count = Inquiry.where(created_at: start_date..end_date, location_preference: 'Vicente Cruz').count
        inquiry_bedspace_count = Inquiry.where(created_at: start_date..end_date, room_type: 'bedspace').count
        inquiry_condo_count = Inquiry.where(created_at: start_date..end_date, room_type: 'condo fully-furnished').count
        inquiry_condo_empty_count = Inquiry.where(created_at: start_date..end_date, room_type: 'condo empty').count
        inquiry_studio_count = Inquiry.where(created_at: start_date..end_date, room_type: 'studio').count
        inquiry_boarding_house_count = Inquiry.where(created_at: start_date..end_date, room_type: 'boarding house').count

        #reviews
        review_count = Review.where(created_at: start_date..end_date).count
        maintenance_satisfaction_score = Review.where(created_at: start_date..end_date).average(:maintenance_satisfaction)
        responsiveness_effectiveness_score = Review.where(created_at: start_date..end_date).average(:responsiveness_effectiveness)
        common_area_cleanliness_score = Review.where(created_at: start_date..end_date).average(:common_area_cleanliness)
        lease_renewal_likelihood_score = Review.where(created_at: start_date..end_date).average(:lease_renewal_likelihood)
        recommend_apartment_score = Review.where(created_at: start_date..end_date).average(:recommend_apartment)
        overall_score = Review.where(created_at: start_date..end_date).average(:overall_score)

        #financial
        total_expenses = Expense.where(created_at: start_date..end_date).sum('expenses.amount')
        tenants_deposits = Deposit.joins(booking: :invoices).where(invoices: { status: Invoice.statuses[:paid], remarks: "Initial" }, created_at: start_date..end_date).sum(:total_amount)
        total_unpaid_invoices = Invoice.where(created_at: start_date..end_date, status: 'unpaid').sum('invoices.total_amount')
        total_payments_amount = Payment.where(created_at: start_date..end_date, status: 'approved').where(payment_mode: 'paymongo')
        .sum("payments.amount") * 0.975
        total_payments_amount += Payment.where(status: 'approved')
        .where.not(payment_mode: 'paymongo').sum("payments.amount")
        gross_earnings = (total_payments_amount + total_unpaid_invoices) - (total_expenses + tenants_deposits)

        @generated_report = {
          start_date: start_date,
          end_date: end_date,

          branches: branches,
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

          review_count: review_count,
          maintenance_satisfaction_score: maintenance_satisfaction_score,
          responsiveness_effectiveness_score: responsiveness_effectiveness_score,
          common_area_cleanliness_score: common_area_cleanliness_score,
          lease_renewal_likelihood_score: lease_renewal_likelihood_score,
          recommend_apartment_score: recommend_apartment_score,
          overall_score: overall_score,

          total_expenses: total_expenses,
          tenants_deposits: tenants_deposits,
          total_unpaid_invoices: total_unpaid_invoices,
          total_payments_amount: total_payments_amount,
          gross_earnings: gross_earnings
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

  def parse_date_month(date_string)
    Date.strptime(date_string, "%Y-%m") rescue nil
  end
end
