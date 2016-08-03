class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :sold_by
      t.integer :book_id
      t.integer :customer_id
      t.string :currency, limit: 5
      t.decimal :price_paid_per_book_orig, precision: 15, scale: 2
      t.decimal :price_paid_per_book_czk, precision: 15, scale: 2
      t.integer :amount
      t.decimal :total_paid, precision: 15, scale: 2
      t.decimal :total_profit, precision: 15, scale: 2
      t.boolean :is_reconciled, default: false

      t.timestamps null: false
    end
  end
end
