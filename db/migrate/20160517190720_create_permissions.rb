class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.integer :user_id
      t.integer :role_id
      t.integer :institution_id
      t.string :institution_type

      t.timestamps null: false
    end
    add_index :permissions, :user_id
    add_index :permissions, :role_id
    add_index :permissions, :institution_id
  end
end
