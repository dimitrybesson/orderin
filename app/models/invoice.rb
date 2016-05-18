class Invoice < ActiveRecord::Base
  belongs_to :order
  belongs_to :user
  has_many :invoice_items, autosave: true

  before_save :populate

  def populate
    order_items = self.order.order_items
    order_items.each do |order_item|
      invoice_item = self.invoice_items.build
      invoice_item.quantity = order_item.quantity
      invoice_item.order_item_id = order_item.id
    end
  end
end
