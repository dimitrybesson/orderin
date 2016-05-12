class InventoryItem < ActiveRecord::Base
  belongs_to :supplier
  belongs_to :item

  def name
    self.item.name
  end

  def formatted_price
    '%.2f' % (self.price / 100.0)
  end

end
