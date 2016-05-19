# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Item.destroy_all

items = [
  "Striploin Steak Cdn Angus 10o Center Cut Chain On",
  "Striploin Steak AA 4 oz End to End",
  "Striploin Steak AA 5 oz End to End",
  "Striploin Steak AA 6 oz End to End",
  "Striploin Steak AA 7 oz End to End",
  "Striploin Steak AA 8 oz End to End",
  "Tenderloin AA Wedge Out 189A 7-8 lb",
  "Cdn Angus AAA Capless Rib 2x2 17-18 lb",
  "Ribeye Steak Cdn Angus AAA 1x 20 oz",
  "Premier Rib Capless Grass Fed Wet Aged 12-14 lbs Ave.",
  "Dry Aged Cdn Prime Ribeye 1x1 12-14 lb",
  "Natural Beef Top Butt 12-14 lb"
]

items.each { |item| Item.create(name: item, description: 'Food') }

# InventoryItem.create(item_id: 3, supplier_id: 4, quantity: 112, price: 59)
# InventoryItem.create(item_id: 6, supplier_id: 4, quantity: 10, price: 121)
# InventoryItem.create(item_id: 7, supplier_id: 4, quantity: 55, price: 154)
# InventoryItem.create(item_id: 1, supplier_id: 4, quantity: 90, price: 199)
# InventoryItem.create(item_id: 2, supplier_id: 4, quantity: 80, price: 170)
# InventoryItem.create(item_id: 4, supplier_id: 4, quantity: 34, price: 12)
# InventoryItem.create(item_id: 8, supplier_id: 4, quantity: 51, price: 345)
# InventoryItem.create(item_id: 32, supplier_id: 4, quantity: 51, price: 345, name: "Striploin Steak AA 4 oz End to End")
