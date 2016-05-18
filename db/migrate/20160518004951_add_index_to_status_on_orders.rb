class AddIndexToStatusOnOrders < ActiveRecord::Migration
  def change
    add_index :orders, :status, using: :gist
  end
end
