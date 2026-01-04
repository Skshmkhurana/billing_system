class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :product_code
      t.integer :stock
      t.float :price
      t.float :tax_percentage

      t.timestamps
    end
  end
end
