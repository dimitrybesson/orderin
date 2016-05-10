class Order < ActiveRecord::Base
  #user
  belongs_to :restaurant
  belongs_to :supplier
  has_many :order_items
end
