class InvoiceItem < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :order_item

  def price
    self.order_item.price
  end

  def subtotal
    self.price * self.quantity
  end

  def formatted_price
    self.order_item.formatted_price
  end

  def formatted_subtotal
    '%.2f' % (self.subtotal / 100.0)
  end

  def update_inventory(delta)
    new_quantity = self.order_item.inventory_item.quantity + delta
    self.order_item.inventory_item.update_attributes(quantity: new_quantity)
  end
end
