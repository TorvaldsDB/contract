class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.date :start_date
      t.date :end_date
      t.string :name
      t.text :descrption

      t.timestamps null: false
    end
  end
end
