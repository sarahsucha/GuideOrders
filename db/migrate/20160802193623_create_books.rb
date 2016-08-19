class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title, limit: 50, null: false
      t.integer :printing_cost_czk, null: false
      t.string :isbn, :limit => 20
      t.date :publish_date
      t.integer :inventory
      t.integer :original_inventory

      t.timestamps null: false
    end
  end
end
