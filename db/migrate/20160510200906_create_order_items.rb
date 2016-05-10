class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :order_id
      t.integer :inventory_item_id
      t.integer :quantity

      t.timestamps null: false
    end
    add_index :order_items, :order_id
    add_index :order_items, :inventory_item_id
  end
end
