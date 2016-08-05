class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :sold_by_id
      t.integer :customer_id
      t.boolean :is_reconciled, default: false

    end
  end
end
