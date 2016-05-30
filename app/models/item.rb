class Item < ActiveRecord::Base
  has_many :inventory_items
  has_many :order_items
  has_many :suppliers, through: :inventory_items

  validates :name, :description, presence: true
end
