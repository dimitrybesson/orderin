class Role < ActiveRecord::Base
  has_and_belongs_to_many :institutions, polymorphic: true, join_table: "institutions_roles_users"
  has_and_belongs_to_many :users, join_table: "institutions_roles_users"
end
