class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :customer_id
      t.date :sold_date, null: false
      t.string :currency_type, limit: 5
      t.integer :czk_conversion_id
      t.boolean :is_reconciled, default: false

      t.timestamps null: false
    end
  end
end
