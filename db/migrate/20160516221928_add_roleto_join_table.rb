class AddRoletoJoinTable < ActiveRecord::Migration
  def change
    add_column :institutions_roles_users, :role_id, :integer
    add_index :institutions_roles_users, :role_id

    add_column :institutions_roles_users, :institution_type, :string
  end
end
