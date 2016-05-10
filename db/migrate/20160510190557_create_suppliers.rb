class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.string :name
      t.string :street_address
      t.string :phone

      t.timestamps null: false
    end
  end
end
