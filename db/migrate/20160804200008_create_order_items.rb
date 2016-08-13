class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :quantity, null: false
      t.integer :price_paid_per_book_orig, null: false
      t.integer :book_id, null: false
      t.integer :order_id, null: false
    end
  end
end
