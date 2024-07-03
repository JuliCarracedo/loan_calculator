class LoanMailer < ApplicationMailer
  default from: 'loans@example.com'

  def your_loan
    @loan = params[:loan]
    @url  = 'http://example.com/login'
    attachments["#{@loan.id.to_s + Time.now.to_i.to_s}.pdf"] = Prawn::LoanPdf.loan_pdf(@loan).render
    mail(to: @loan[:email], subject: 'Revise your Loan')
  end
end
