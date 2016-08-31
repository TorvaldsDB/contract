class CreateRentPhases < ActiveRecord::Migration
  def change
    create_table :rent_phases do |t|
      t.date :start_date
      t.date :end_date
      t.decimal :price
      t.integer :cycles
      t.integer :contract_id

      t.timestamps null: false
    end
  end
end
