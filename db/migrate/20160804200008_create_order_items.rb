class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :quantity
      t.integer :price_paid_per_book_orig
      t.integer :book_id
      t.integer :order_id
    end
  end
end
