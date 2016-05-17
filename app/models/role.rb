class Role < ActiveRecord::Base
  has_many :permissions
  has_many :users, through: :permissions
  has_many :institutions, through: :permissions
end
