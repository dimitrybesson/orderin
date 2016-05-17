class Supplier < ActiveRecord::Base
  has_many :inventory_items
  has_many :orders
  # has_and_belongs_to_many :users, as: :institution, join_table: "institutions_roles_users"
  # has_and_belongs_to_many :roles, as: :institution, join_table: "institutions_roles_users"
  has_many :invoices, through: :orders
end
