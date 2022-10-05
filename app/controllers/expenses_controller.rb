class ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_expense, only: [:show, :edit, :update]
  before_action :check_restriction

  def index
    @q = Expense.all.ransack(params[:q])
    @expenses = @q.result(distinct: true)
  end

  def show
  end

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(expense_params)
    if @expense.save
      @expense.set_processed_by(current_user.email)
      redirect_to expense_path(@expense), notice: 'New Expense Added'
    else
      render :new
    end
  end

  private
  
  def check_restriction
    if current_user.tenant?
      redirect_to authenticated_root_path, notice: 'Access Denied'
    end
  end

  def set_expense
    @expense = Expense.find(params[:id]) 
  end
  
  def expense_params
    params.require(:expense).permit(:title, :description, :amount, :processed_by, :proof)
  end
  
end
