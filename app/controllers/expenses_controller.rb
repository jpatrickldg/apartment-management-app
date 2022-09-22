class ExpensesController < ApplicationController
  before_action :set_expense, only: [ :show, :edit, :update ]

  def index
    @expenses = Expense.all 
  end

  def show
  end

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(expense_params)
    email = current_user.email
    if @expense.save!
      @expense.set_processed_by(email)
      redirect_to expense_path(@expense), notice: 'New Expense Added'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @expense.update(expense_params)
      redirect_to root_path, notice: 'Updated Successfully'
    else
      render :edit
    end
  end

  private

  def set_expense
    @expense = Expense.find(params[:id]) 
  end
  
  def expense_params
    params.require(:expense).permit(:title, :description, :amount, :processed_by, :proof)
  end
  
end
