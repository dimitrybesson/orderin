class InventoryItem < ActiveRecord::Base
  belongs_to :supplier
  belongs_to :item

  include ItemsHelper
end
