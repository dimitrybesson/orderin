class InvoiceItem < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :order_item

  validates :invoice, :order_item, :quantity, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }

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

  def delta_is_positive?
    if (self.quantity - self.order_item.quantity) > 0
      return true
    else
      return false
    end
  end

  def delta_is_negative?
    if (self.quantity - self.order_item.quantity) < 0
      return true
    else
      return false
    end
  end
end
