class Restaurant < ActiveRecord::Base
  has_many :orders
  has_many :order_items, through: :orders
  has_and_belongs_to_many :users
end
