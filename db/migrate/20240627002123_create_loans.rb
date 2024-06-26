class CreateLoans < ActiveRecord::Migration[7.1]
  def change
    create_table :loans do |t|
      t.string :address
      t.integer :loan_term
      t.float :purchase_price
      t.float :repair_price
      t.float :arv
      t.string :email
      t.string :name
      t.string :phone
      t.float :loan
      t.float :profit

      t.timestamps
    end
  end
end
