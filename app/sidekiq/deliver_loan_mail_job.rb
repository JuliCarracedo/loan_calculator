# frozen_string_literal: true

class DeliverLoanMailJob
  include Sidekiq::Job

  def perform(loan_id)
    loan = Loan.find(loan_id)
    LoanMailer.with(loan: loan).your_loan.deliver_now
  end
end
