class InventoryItem < ActiveRecord::Base
  belongs_to :supplier
  belongs_to :item

  def name
    self.item.name
  end
end
