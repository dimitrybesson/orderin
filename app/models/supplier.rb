class Supplier < ActiveRecord::Base
  has_many :inventory_items
  has_many :orders
  has_and_belongs_to_many :users
end
