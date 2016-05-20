class Permission < ActiveRecord::Base
  belongs_to :user
  belongs_to :role
  belongs_to :institution, polymorphic: true
  belongs_to :restaurant, foreign_key: :institution_id

end
