class InvoiceItem < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :order_item

  validates :invoice, :order_item, :quantity, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }

  def price
    order_item.price
  end

  def subtotal
    price * quantity
  end

  def formatted_price
    order_item.formatted_price
  end

  def formatted_subtotal
    '%.2f' % (subtotal / 100.0)
  end

  def update_inventory(delta)
    new_quantity = order_item.inventory_item.quantity + delta
    order_item.inventory_item.update_attributes(quantity: new_quantity)
  end

  def delta
    quantity - order_item.quantity
  end

  def delta_is_positive?
    delta > 0
  end

  def delta_is_negative?
    delta < 0
  end
end
