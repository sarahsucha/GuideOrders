class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title, limit: 50
      t.decimal :printing_cost_czk, precision: 15, scale: 2
      t.string :isbn, :limit => 20
      t.date :publish_date

      t.timestamps null: false
    end
  end
end
