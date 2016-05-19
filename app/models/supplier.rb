class Supplier < ActiveRecord::Base
  has_many :inventory_items
  has_many :orders
  has_many :users, through: :permissions
  has_many :roles, through: :permissions
  has_many :invoices, through: :orders
  has_many :permissions, as: :institution

  def master?(user)
    Permission.where(user_id: user.id, institution_id: id, institution_type: "Supplier", role_id: "1").any?
  end

end
