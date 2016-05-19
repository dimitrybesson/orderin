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

  def restaurant_orderer?
    Permission.where(user_id: id, institution_type: "Restaurant", role: (1..2)).any?
  end

end
