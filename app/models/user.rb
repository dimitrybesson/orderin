class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # has_and_belongs_to_many :institutions, polymorphic: true, join_table: "institutions_roles_users"
  # has_and_belongs_to_many :roles, join_table: "institutions_roles_users"
end
