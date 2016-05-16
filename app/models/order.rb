class Order < ActiveRecord::Base
  #user
  belongs_to :restaurant
  belongs_to :supplier
  has_many :order_items

  def total
    self.order_items.inject(0) { |sum, item| sum + item.subtotal }
  end

  def formatted_total
    '%.2f' % (self.total / 100.0)
  end

  def exclude_list
    self.order_items.map { |item| item.inventory_item_id }
  end

  def accessible_items
    self.supplier.inventory_items.where.not(id: self.exclude_list)
  end
end
