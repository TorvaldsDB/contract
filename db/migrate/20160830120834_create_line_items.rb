class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.date :start_date
      t.date :end_date
      t.decimal :unit_price
      t.string :units
      t.decimal :total
      t.integer :invoice_id

      t.timestamps null: false
    end
  end
end
