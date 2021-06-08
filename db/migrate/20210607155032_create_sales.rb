class CreateSales < ActiveRecord::Migration[6.1]
  def change
    create_table :sales do |t|
      t.bigint :product_id
      t.integer :quantity
      t.integer :revenue
      t.date :date

      t.timestamps
    end
    add_foreign_key :sales, :products
    add_index :sales, :date
  end
end
