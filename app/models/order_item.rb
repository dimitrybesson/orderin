class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :item

  include InventoryItemsHelper
end
