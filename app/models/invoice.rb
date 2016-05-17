class Invoice < ActiveRecord::Base
  belongs_to :order
  belongs_to :user
  has_many :invoice_items
end
