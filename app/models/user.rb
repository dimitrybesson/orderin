class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :orders
  has_many :permissions
  has_many :roles, through: :permissions
  has_many :restaurants, through: :permissions, source: :institution, source_type: "Restaurant"
  has_many :suppliers, through: :permissions, source: :institution, source_type: "Supplier"

  def restaurant_worker?
    restaurants.any?
  end

  def supplier_worker?
    suppliers.any?
  end

  def restaurant_orderer?
    Permission.where(user_id: id, institution_type: "Restaurant", role: (1..2)).any?
  end

  def restaurant_master?
    Permission.where(user_id: id, institution_type: "Restaurant", role: 1).any?
  end

  def restaurant_master_this?(restaurant)
    Permission.where(user_id: id, restaurant_id: restaurant.id, institution_type: "Restaurant", role: 1).any?
  end

  def clearance(restaurant)
    case Permission.find_by(user_id: id, institution_id: restaurant.id, institution_type: "Restaurant").role_id
    when 1
      return "Master"
    when 2
      return "Privileged"
    when 3
      return "Restricted"
    end
  end

  def deliveries
    restaurants.map { |restaurant| restaurant.orders.where("status ? 'shipped' AND NOT status ? 'received'") }.flatten
  end

  def deliveries_count
    deliveries.count
  end

end
