require 'prawn'

module Prawn
  module LoanPdf
    def self.loan_pdf(loan)
      pdf = Document.new
      pdf.font_size 12
      pdf.indent 40, 40 do
        pdf.move_down 10
        table_data = [
          ['Name:', loan.name],
          ['Email:', loan.email],
          ['Phone:', loan.phone],
          ['Address:', loan.address],
          ['Purchase Price:', loan.purchase_price.to_s],
          ['Repair Price:', loan.repair_price.to_s],
          ['ARV:', loan.arv],
        ]
        pdf.move_down 10
        pdf.font_size 16
        pdf.text 'Your loan value is', align: :center
        pdf.move_down 10
        pdf.font_size 24
        pdf.text loan.loan.to_s, align: :center

        pdf.move_down 10
        pdf.font_size 16
        pdf.text 'The loan profit is:', align: :center, color: 'aaaaaa'
        pdf.move_down 10
        pdf.font_size 24
        pdf.text loan.profit.to_s, align: :center, color: 'aaaaaa'
        pdf.move_down 10
        pdf.font_size 12
        pdf.text 'Yearly interest: 13%', align: :center, color: 'aaaaaa'
      end
      pdf
    end

    def self.prawn
      Prawn::Document.new
    end
  end
end
