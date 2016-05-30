class Permission < ActiveRecord::Base
  belongs_to :user
  belongs_to :role
  belongs_to :institution, polymorphic: true
  belongs_to :restaurant, foreign_key: :institution_id

  # Allows suppliers to have users with different access rights
  # belongs_to :supplier, foreign_key: :institution_id

  validates :user, :role, :institution, :institution_type, presence: true

  # Somewhat redundant with institution/institution_type check above
  validates :institution_type, inclusion: { in: %w(Restaurant Supplier) }

end
