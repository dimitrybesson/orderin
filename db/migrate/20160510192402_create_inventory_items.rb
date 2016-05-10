class CreateInventoryItems < ActiveRecord::Migration
  def change
    create_table :inventory_items do |t|
      t.integer :item_id
      t.integer :supplier_id
      t.integer :quantity
      t.integer :price

      t.timestamps null: false
    end
    add_index :inventory_items, :item_id
    add_index :inventory_items, :supplier_id
  end
end
