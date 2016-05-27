class Order < ActiveRecord::Base

  belongs_to :user
  belongs_to :restaurant
  belongs_to :supplier
  has_many :order_items
  has_one :invoice # this can be a has_one relationship

  def total
    order_items.inject(0) { |sum, item| sum + item.subtotal }
  end

  def formatted_total
    '%.2f' % (total / 100.0)
  end

  def exclude_list
    order_items.map { |item| item.inventory_item_id }
  end

  def accessible_items
    supplier.inventory_items.where.not(id: exclude_list)
  end

  def submitted?
    status["submitted"]
  end

  def seen?
    status["seen"]
  end

  def invoiced?
    status["invoiced"]
  end

  def shipped?
    status["shipped"]
  end

  def received?
    status["received"]
  end

  def paid?
    status["paid"]
  end

  def completed?
    status["completed"]
  end

  def seen
    if !status["seen"]
      status["seen"] = true
      save
    end
  end

  def has_incomplete_invoice?
    invoice.present? && !invoiced?
  end

  def has_no_invoice?
    invoice.nil?
  end

end
