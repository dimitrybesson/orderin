class CreateJoinTableInstitutionRoleUser < ActiveRecord::Migration
  def change
    create_join_table :institutions, :roles, :users, table_name: :institutions_roles_users do |t|
      t.index :institution_id
      t.index :role_id
      t.index :user_id
  end
end
