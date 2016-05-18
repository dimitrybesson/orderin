class Restaurant < ActiveRecord::Base
  has_many :orders
  has_many :suppliers, through: :orders
  has_many :order_items, through: :orders
  has_many :users, through: :permissions
  has_many :roles, through: :permissions
  has_many :invoices, through: :orders
  has_many :permissions, as: :institution
end
