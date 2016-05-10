# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Item.destroy_all

items = %w(chicken beef pork tomato potato parsley carrot apple orange tortilla)

items.each { |item| Item.create(name: item, description: 'Food') }

Supplier.create(name: 'Sysco', street_address: '7055 Kennedy Rd, Mississauga, ON, L5S1Y7', phone: '9056708605')

InventoryItem.create(item_id: 3, supplier_id: 1, quantity: 112, price: 59)
InventoryItem.create(item_id: 6, supplier_id: 1, quantity: 10, price: 121)
InventoryItem.create(item_id: 7, supplier_id: 1, quantity: 55, price: 154)
InventoryItem.create(item_id: 1, supplier_id: 1, quantity: 90, price: 199)
InventoryItem.create(item_id: 2, supplier_id: 1, quantity: 80, price: 170)
InventoryItem.create(item_id: 4, supplier_id: 1, quantity: 34, price: 12)
InventoryItem.create(item_id: 8, supplier_id: 1, quantity: 51, price: 345)
