class InventoryItem < ActiveRecord::Base
  belongs_to :supplier
  belongs_to :item

  validates :item, :supplier, :quantity, :price, :name, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }

  def formatted_price
    '%.2f' % (self.price / 100.0)
  end
end
