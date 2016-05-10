class Supplier < ActiveRecord::Base
  has_many :inventory_items
  has_many :orders
end
