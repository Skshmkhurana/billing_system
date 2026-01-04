class CreateBills < ActiveRecord::Migration[8.0]
  def change
    create_table :bills do |t|
      t.references :customer, null: false, foreign_key: true
      t.float :total_amount
      t.float :paid_amount

      t.timestamps
    end
  end
end
