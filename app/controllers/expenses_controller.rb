class ExpensesController < ApplicationController

  def index
    @expenses = Expense.all 
  end

  def show
    @expense = Expense.find(params[:id])
  end

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(expense_params)

    if @expense.save!
      redirect_to root_path, notice: 'New Expense Added'
    else
      render :new
    end
  end

  def edit
    @expense = Expense.find(params[:id]) 
  end

  def update
    @expense = Expense.find(params[:id]) 

    if @expense.update(expense_params)
      redirect_to root_path, notice: 'Updated Successfully'
    else
      render :edit
    end
  end

  private

  def expense_params
    params.require(:expense).permit(:title, :description, :amount )
  end
end
