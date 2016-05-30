class Invoice < ActiveRecord::Base
  belongs_to :order
  belongs_to :user
  has_many :invoice_items, autosave: true

  validates :user, :order, presence: true
  validate :has_no_more_than_one_invoice

  before_save :populate

  def has_no_more_than_one_invoice
    if Invoice.where(order_id: order_id).count > 0
      errors.add(:too_many_invoices, "An invoice for this order already exists.")
    end
  end

  def populate
    order_items = self.order.order_items
    order_items.each do |order_item|
      invoice_item = self.invoice_items.build
      invoice_item.quantity = order_item.quantity
      invoice_item.order_item_id = order_item.id
    end
  end

  def price_formatter(price_in_cents)
    '%.2f' % (price_in_cents / 100.0)
  end

  def total
    price_formatter(invoice_items.inject(0) { |sum, item| sum + item.price })
  end
end
