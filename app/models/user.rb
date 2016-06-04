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

  def works_at?(institution_id, institution_type)
    Permission.find_by(user_id: id, institution_id: institution_id, institution_type: institution_type).present?
  end

  def restaurant_worker?
    restaurants.any?
  end

  def supplier_worker?
    suppliers.any?
  end

  def restaurant_orderer?
    Permission.where(user_id: id, institution_type: "Restaurant", role_id: (Role.find_by(name: "master").id..Role.find_by(name: "privileged").id)).any?
  end

  def restaurant_master?
    Permission.where(user_id: id, institution_type: "Restaurant", role_id: Role.find_by(name: "master").id).any?
  end

  def restaurant_master_this?(restaurant)
    Permission.find_by(user_id: id, institution_id: restaurant.id, institution_type: "Restaurant", role_id: Role.find_by(name: "master").id).present?
  end

  def clearance(restaurant)
    Permission.find_by(user_id: id, institution_id: restaurant.id, institution_type: "Restaurant").role.name
  end

  def deliveries
    restaurants.map { |restaurant| restaurant.orders.where("status ? 'shipped' AND NOT status ? 'received'") }.flatten
  end

  def deliveries_count
    deliveries.count
  end

end
