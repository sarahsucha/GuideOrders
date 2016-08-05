class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :quantity
      t.string :currency_type, limit: 5
      t.integer :price_paid_per_book_orig
      t.integer :book_id
      t.integer :order_id
      t.integer :czk_conversion_id

      t.timestamps null: false
    end
  end
end
