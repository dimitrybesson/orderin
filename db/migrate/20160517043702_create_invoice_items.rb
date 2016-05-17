class CreateInvoiceItems < ActiveRecord::Migration
  def change
    create_table :invoice_items do |t|
      t.integer :invoice_id
      t.integer :order_item_id
      t.integer :quantity

      t.timestamps null: false
    end
    add_index :invoice_items, :invoice_id
    add_index :invoice_items, :order_item_id
  end
end
