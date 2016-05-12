class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :inventory_item

  def subtotal
    self.price * self.quantity
  end

  def name
    self.inventory_item.item.name
  end

  def price
    self.inventory_item.price
  end
end
