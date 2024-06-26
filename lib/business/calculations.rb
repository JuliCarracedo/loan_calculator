module Business::Calculations
  MAX_LOAN_BY_PURCHASE_PRICE = 0.9
  MAX_LOAN_BY_ARV = 0.7
  YEARLY_INTEREST = 0.13

  def calculate_loan(purchase_price, arv)
    loan_by_purchase = purchase_price * MAX_LOAN_BY_PURCHASE_PRICE
    loan_by_arv = arv * MAX_LOAN_BY_PURCHASE_PRICE

    [loan_by_purchase, loan_by_arv].min
  end

  def calculate_profit(months, loan, arv)
    monthly_interest = YEARLY_INTEREST / 12
    total_interest = loan * months * monthly_interest
    arv - loan - total_interest
  end
end
