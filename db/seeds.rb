# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


items = [
  "3 year old Thunderoak Gouda", "Beemster Masterchoice", "Cantenaar", "Chili Gouda", "Grizzly", "Majestic Henry Feels the Heat"
]

items.each { |item| Item.create(name: item, description: 'Food') }

Item.find_by(name: "3 year old Thunderoak Gouda").update_attributes(description: "3 year old Thunderoak Gouda is a pasteurized cow’s milk gouda from Thunderbay’s Thunderoak Dairy. A husband and wife operation both of whom are of Dutch origin. It is a three year in-house aged Gouda that Cheese Boutique brings in at one year.")
Item.find_by(name: "Beemster Masterchoice").update_attributes(description: "In the modern market, cheesemakers often try to come up with the “next big cheese” and crowd the shelves with trendy new items. Beemster does just the opposite with Master’s Choice cheese; it goes back in time to create a “new” cheese out of an old recipe. Through a special recipe, fine milk, and extra washing of curds, a cheese was crafted that would mature for a longer time. The result was a cheese with a broad profile. The flavors develop an aged Dutch character, but the cheese is softer and creamier on the palate due to the extra washing. Master Cheesemaker, Pieter ter Beek selects the wheels that meet his standards, hence the name Master’s Choice.")
Item.find_by(name: "Cantenaar").update_attributes(description: "Cantenaar cheese is a low fat, and low sodium cheese from Holland. It is aged six months in-house developing a nutty flavour. This is one of the best tasting low fat cheeses, weighing in at 14% milk fat.")
Item.find_by(name: "Chili Gouda").update_attributes(description: "Chili Gouda cheese is an exceptional combination of mild cow’s milk Dutch cheese and spicy chili pieces. This young Dutch Gouda infused with Sambal Oelek, an Indonesian hot spice mix. Hot, tangy and very flavourful.")
Item.find_by(name: "Grizzly").update_attributes(description: "Grizzly cheese cow’s milk, Gouda-styled cheese from Red Deer, Alberta. Aged eighteen months before it hits our shelves. Further aging in-house creates intense toffee flavours and a crystalline texture.  A lactose-free cheese that some call the best in Canada.")
Item.find_by(name: "Majestic Henry Feels the Heat").update_attributes(description: "Majestic Henry Feels the Heat cheese is a grassfed water buffalo milk cheese infused with chilies. Made in Hagerville, On. Produced in very small batches. Aged six month in-house.")


# InventoryItem.create(item_id: 3, supplier_id: 4, quantity: 112, price: 59)
# InventoryItem.create(item_id: 6, supplier_id: 4, quantity: 10, price: 121)
# InventoryItem.create(item_id: 7, supplier_id: 4, quantity: 55, price: 154)
# InventoryItem.create(item_id: 1, supplier_id: 4, quantity: 90, price: 199)
# InventoryItem.create(item_id: 2, supplier_id: 4, quantity: 80, price: 170)
# InventoryItem.create(item_id: 4, supplier_id: 4, quantity: 34, price: 12)
# InventoryItem.create(item_id: 8, supplier_id: 4, quantity: 51, price: 345)
# InventoryItem.create(item_id: 32, supplier_id: 4, quantity: 51, price: 345, name: "Striploin Steak AA 4 oz End to End")
