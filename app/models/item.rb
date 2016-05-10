class Item < ActiveRecord::Base
  has_many :inventory_items
  has_many :order_items
end
