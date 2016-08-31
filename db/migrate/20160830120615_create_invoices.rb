class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.date :start_date
      t.date :end_date
      t.date :due_date
      t.decimal :total
      t.string :renter_name
      t.integer :contract_id

      t.timestamps null: false
    end
  end
end
