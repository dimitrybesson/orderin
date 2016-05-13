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

  def formatted_price
    '%.2f' % (self.price / 100.0)
  end

  def formatted_subtotal
    '%.2f' % (self.subtotal / 100.0)
  end

  def deduct_from_inventory
    new_quantity = self.inventory_item.quantity - self.quantity
    self.inventory_item.update_attributes(quantity: new_quantity)
  end


end
