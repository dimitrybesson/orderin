class AddStatusToOrders < ActiveRecord::Migration
  def change
    enable_extension "hstore"
    add_column :orders, :status, :hstore
  end
end
