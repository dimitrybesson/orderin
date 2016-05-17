class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :user_id
      t.integer :order_id

      t.timestamps null: false
    end
    add_index :invoices, :user_id
    add_index :invoices, :order_id
  end
end
