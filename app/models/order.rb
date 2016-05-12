class Order < ActiveRecord::Base
  #user
  belongs_to :restaurant
  belongs_to :supplier
  has_many :order_items

  def total
    self.order_items.inject(0) { |sum, item| sum + item.subtotal }
  end
end
