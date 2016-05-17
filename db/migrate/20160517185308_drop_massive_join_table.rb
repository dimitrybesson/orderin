class DropMassiveJoinTable < ActiveRecord::Migration
  def change
    drop_join_table :institutions, :users, table_name: :institutions_roles_users
  end
end
