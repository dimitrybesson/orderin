class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :restaurant_id
      t.integer :supplier_id
      t.integer :user_id
      t.text :instructions
      t.datetime :delivery_date

      t.timestamps null: false
    end
    add_index :orders, :restaurant_id
    add_index :orders, :supplier_id
    add_index :orders, :user_id
  end
end
