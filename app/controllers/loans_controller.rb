class LoansController < ApplicationController
  include Business::Calculations

  def new
    @loan = Loan.new
  end

  def create
    loan = calculate_loan(loan_params[:purchase_price].to_f, loan_params[:arv].to_f)
    profit = calculate_profit(loan_params[:loan_term].to_i, loan, loan_params[:arv].to_f)
    all_loan_params = loan_params.merge({ loan:, profit: })

    @loan = Loan.new(all_loan_params)

    if @loan.save
      LoanMailer.with(loan: @loan).your_loan.deliver_later
      redirect_to loan_path(@loan)
    else
      render :new
    end
  end

  def show
    @loan = Loan.find(params[:id])
  end

  private

  def loan_params
    params.require(:loan).permit(:address, :loan_term, :purchase_price, :repair_price, :arv, :name, :email, :phone)
  end
end
