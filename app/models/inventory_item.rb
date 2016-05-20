class InventoryItem < ActiveRecord::Base
  belongs_to :supplier
  belongs_to :item

  def formatted_price
    '%.2f' % (self.price / 100.0)
  end
end
