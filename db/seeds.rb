# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'factory_bot_rails'

include FactoryBot::Syntax::Methods

OrderItem.destroy_all
Order.destroy_all
Item.destroy_all
User.destroy_all

admin = create(:admin)
user = create(:user)
merchant_1 = create(:merchant)

merchant_2, merchant_3, merchant_4 = create_list(:merchant, 3)

inactive_merchant_1 = create(:inactive_merchant)
inactive_user_1 = create(:inactive_user)

item_1 = create(:item, user: merchant_1)
item_2 = create(:item, user: merchant_2)
item_3 = create(:item, user: merchant_3)
item_4 = create(:item, user: merchant_4)
create_list(:item, 10, user: merchant_1)

inactive_item_1 = create(:inactive_item, user: merchant_1)
inactive_item_2 = create(:inactive_item, user: inactive_merchant_1)

Random.new_seed
rng = Random.new

order = create(:completed_order, user: user)
create(:fulfilled_order_item, order: order, item: item_1, unit_price: 1, quantity: 1, created_at: (rng.rand(3)+1).days.ago, updated_at: rng.rand(59).minutes.ago)
create(:fulfilled_order_item, order: order, item: item_2, unit_price: 2, quantity: 1, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)
create(:fulfilled_order_item, order: order, item: item_3, unit_price: 3, quantity: 1, created_at: (rng.rand(5)+1).days.ago, updated_at: rng.rand(59).minutes.ago)
create(:fulfilled_order_item, order: order, item: item_4, unit_price: 4, quantity: 1, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)

# pending order
order = create(:order, user: user)
create(:order_item, order: order, item: item_1, unit_price: 1, quantity: 1)
create(:fulfilled_order_item, order: order, item: item_2, unit_price: 2, quantity: 1, created_at: (rng.rand(23)+1).days.ago, updated_at: rng.rand(23).hours.ago)

order = create(:cancelled_order, user: user)
create(:order_item, order: order, item: item_2, unit_price: 2, quantity: 1, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)
create(:order_item, order: order, item: item_3, unit_price: 3, quantity: 1, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)

order = create(:completed_order, user: user)
create(:fulfilled_order_item, order: order, item: item_1, unit_price: 1, quantity: 1, created_at: (rng.rand(4)+1).days.ago, updated_at: rng.rand(59).minutes.ago)
create(:fulfilled_order_item, order: order, item: item_2, unit_price: 2, quantity: 1, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)

hyrule_market = User.create(name: "Hyrule Market", email: "villageperson1@gmail.com", password: "link", address: "123 Central Plaza", city: "Hyrule Castle", state: "Hyrule Kingdom", zipcode: 12345, role: 1)
potions_shop = User.create(name: "Potions Shop", email: "potionpal@gmail.com", password: "link", address: "321 Village Plaza", city: "Kakariko Village", state: "Hyrule Kingdom", zipcode: 12345, role: 1)
ranch_vendors = User.create(name: "Ranch Vendors", email: "lonlon@gmail.com", password: "link", address: "1 Lon Lon Ranch", city: "Lon Lon Ranch", state: "Hyrule Kingdom", zipcode: 12345, role: 1)
kokiri_emporium = User.create(name: "Kokiri Emporium", email: "creatureoftheforest@gmail.com", password: "link", address: "246 Deku Nut Drive", city: "Kokiri Forest", state: "Hyrule Kingdom", zipcode: 12345, role: 1)
biggoron_outfitters = User.create(name: "Biggoron Outfitters", email: "toobig@gmail.com", password: "link", address: "357 Mountain Vista Lane", city: "Death Mountain", state: "Hyrule Kingdom", zipcode: 12345, role: 1)
zora_aura = User.create(name: "Zora Aura", email: "zorafromborabora@gmail.com", password: "link", address: "468 River Road", city: "Zora's Domain", state: "Hyrule Kingdom", zipcode: 12345, role: 1)
lakeside_concessions = User.create(name: "Lakeside Concessions", email: "idratherbeatthelake@gmail.com", password: "link", address: "1 Lake Shore Drive", city: "Lake Hylia", state: "Hyrule Kingdom", zipcode: 12345, role: 1)
stolen_goods = User.create(name: "Stolen Goods", email: "thievesshouldbewomen@gmail.com", password: "link", address: "321 Gerudo Gallery", city: "Gerudo Fortress", state: "Hyrule Kingdom", zipcode: 12345, role: 1)
temple_of_time_gift_shop = User.create(name: "Temple of Time gift shop", email: "secret@gmail.com", password: "link", address: "1 Time Street", city: "Hyrule Castle", state: "Hyrule Kingdom", zipcode: 12345, role: 1)
tingles_maps = User.create(name: "Tingle's Maps", email: "imafairyipromise@gmail.com", password: "link", address: "4 Great Bay Boulevard", city: "Great Bay", state: "Termina", zipcode: 12346, role: 1)
toads_market = User.create(name: "Toad's Market", email: "mushroom@gmail.com", password: "mario", address: "123 Pipe Drive", city: "Toadstool's Castle", state: "Mushroom Kingdom", zipcode: 54321, role: 1)
koopa_troopa_exchange = User.create(name: "Koopa Troopa Exchange", email: "imshy@gmail.com", password: "mario", address: "222 Rainbow Road", city: "Rainbow Cruise", state: "Mushroom Kingdom", zipcode: 54321, role: 1)
navi = User.create(name: "Navi", email: "fairy@gmail.com", password: "link", address: "1 Fairy Place", city: "Fairy Fountain", state: "Hyrule Kingdom", zipcode: 12345, role: 1)

navi.items.create(name: "Headache", image: "https://vignette.wikia.nocookie.net/zelda/images/2/2c/Navi_Artwork.png/revision/latest?cb=20090319134157", price: 0.00, quantity: 99999999, description: "HEY!!! LISTEN!!!!!!")

hyrule_market.items.create(name: "Bow", image: "https://vignette.wikia.nocookie.net/zelda/images/b/b1/Fairy_Bow.png/revision/latest?cb=20090318100724", price: 15.0, quantity: 20, description: "This is bow. It is for shooting arrows. It's useful when you don't want to get close to an enemy.")
hyrule_market.items.create(name: "Bombs", image: "https://vignette.wikia.nocookie.net/zelda/images/b/bf/Bomb_%28Ocarina_of_Time%29.png/revision/latest?cb=20091226020445", price: 5.0, quantity: 200, description: "These are bombs. They are good for blowing up things. It is also a dodongo's favorite snack.")
hyrule_market.items.create(name: "Hylian Shield", image: "https://tshop.r10s.com/366/a4a/25e6/d2d9/a034/a5fd/fe5b/1152e8aab8c4544489145b.jpg", price: 80.0, quantity: 4, description: "It is a big, grown-up shield that could be useful if you have a wooden shield that burns when it touches fire.")
hyrule_market.items.create(name: "Adult Wallet", image: "https://vignette.wikia.nocookie.net/zelda/images/5/53/Adult%27s_Wallet_%28Ocarina_of_Time%29.png/revision/latest?cb=20091226143655", price: 200.0, quantity: 1000, description: "This big wallet will allow to carry all the money you need. You are a grown-up! You need a bigger wallet.")
hyrule_market.items.create(name: "Arrows", image: "https://vignette.wikia.nocookie.net/zelda/images/4/47/Arrow_%28Ocarina_of_Time%29.png/revision/latest?cb=20091226145057", price: 2.0, quantity: 44, description: "These arrows are great for shooting with your bow! Obviously, without a bow they are mainly for decoration.")

potions_shop.items.create(name: "Red Potion", image: "https://vignette.wikia.nocookie.net/zelda/images/7/7f/Red_Potion_%28Majora%27s_Mask%29.png/revision/latest?cb=20091222185020", price: 15.0, quantity: 37, description: "This red potion is great for replenishing your health, especially if you've had altercations with monsters lately.")
potions_shop.items.create(name: "Blue Potion", image: "https://vignette.wikia.nocookie.net/zelda/images/b/b0/Blue_Potion_%28Majora%27s_Mask%29.png/revision/latest?cb=20091222185536", price: 29.99, quantity: 23, description: "This blue potion can heal your health AND magic. Pretty cool right?")
potions_shop.items.create(name: "Green Potion", image: "https://vignette.wikia.nocookie.net/zelda/images/b/ba/Green_Potion_%28Majora%27s_Mask%29.png/revision/latest?cb=20091222183910", price: 19.99, quantity: 32, description: "This potion can help you replenish you magic. You use magic, right?")
potions_shop.items.create(name: "Poe", image: "https://vignette.wikia.nocookie.net/zelda/images/2/29/Poe_%28Majora%27s_Mask%29.png/revision/latest?cb=20100412172931", price: 9.99, quantity: 4, description: "Believe it or not, this is a ghost in a bottle. You can drink it and it might heal you, but it might hurt you.")

ranch_vendors.items.create(name: "Lon Lon Milk", image: "https://vignette.wikia.nocookie.net/zelda/images/e/e7/Lon_Lon_Milk_%28Ocarina_of_Time%29.png/revision/latest?cb=20120205190510", price: 2.99, quantity: 99999999, description: "This is Lon Lon Ranch. We milk our cows every day and all we have is milk. But it's GOOD milk.")

kokiri_emporium.items.create(name: "Deku Stick", image: "https://vignette.wikia.nocookie.net/zelda/images/e/ee/Deku_Stick.png/revision/latest?cb=20091220220017", price: 2.00, quantity: 231, description: "It's a stick. It's best use is to carry fire from one place to another. Do not try to use this as a sword!")
kokiri_emporium.items.create(name: "Deku Nut", image: "https://vignette.wikia.nocookie.net/zelda/images/c/c9/Deku_Nut_%28Ocarina_of_Time%29.png/revision/latest?cb=20091222095936", price: 1.00, quantity: 56, description: "We basically never run out of these. This is probably the most useless item in all of Hyrule. But they are cheap!")
kokiri_emporium.items.create(name: "Slingshot", image: "https://vignette.wikia.nocookie.net/zelda/images/1/1e/Slingshot_%28Twilight_Princess%29.png/revision/latest?cb=20090404003841", price: 14.99, quantity: 12, description: "This slingshot is fun and easy to use for a child. Deku seeds work really well for it!")
kokiri_emporium.items.create(name: "Deku Seeds", image: "https://vignette.wikia.nocookie.net/zelda/images/b/bd/Deku_Seeds.png/revision/latest?cb=20100125025438", price: 0.50, quantity: 321, description: "These seeds are cheap and easy to use with a slingshot! Highly recommend for fighting plant monsters!")

biggoron_outfitters.items.create(name: "Biggoron Sword", image: "https://vignette.wikia.nocookie.net/zelda/images/7/77/Biggoron%27s_Sword.png/revision/latest?cb=20091009213255", price: 999.99, quantity: 1, description: "This is an excellent giant sword. It's so big you need both your hands, but you can FEEL the power. It is much better than the Giant's Knife.")
biggoron_outfitters.items.create(name: "Bomb Bag", image: "https://vignette.wikia.nocookie.net/zelda/images/e/e5/Bomb_Bag_%28Ocarina_of_Time%29.png/revision/latest?cb=20100125065656", price: 79.99, quantity: 21, description: "This bag holds bombs. It is made from a dodongo's stomach. It is perfectly safe.")
biggoron_outfitters.items.create(name: "Megaton Hammer", image: "https://vignette.wikia.nocookie.net/zelda/images/c/c3/Megaton_Hammer_Artwork.png/revision/latest?cb=20100328010702", price: 342.21, quantity: 1, description: "The goron's ancient hero once used this to fight off a giant dragon. It's pretty powerful, if you can lift it.")
biggoron_outfitters.items.create(name: "Giant's Knife", image: "https://vignette.wikia.nocookie.net/zelda/images/3/32/Giant%27s_Knife.png/revision/latest?cb=20090512220914", price: 32.12, quantity: 1, description: "This used to be a big long sword, but it broke because it was poorly made. It's still kinda cool though, right?")
biggoron_outfitters.items.create(name: "Red Tunic", image: "https://vignette.wikia.nocookie.net/zelda/images/9/97/Goron_Tunic_Artwork.png/revision/latest?cb=20091009212758", price: 22.2, quantity: 32, description: "This tunic can help you withstand extremely high temperatures! Isn't that great!? This sells extremely well in the South.")

zora_aura.items.create(name: "Cool-looking Flippers", image: "https://vignette.wikia.nocookie.net/zelda/images/a/ab/Zora%27s_Flippers_%28A_Link_to_the_Past%29.png/revision/latest?cb=20090424000756", price: 22.22, quantity: 34, description: "These flippers are cool lookin'! You can pretend you are a Zora, and swim around!")
zora_aura.items.create(name: "Guitar", image: "https://vignette.wikia.nocookie.net/zelda/images/1/12/Majora%27s_Mask_Instruments_Guitar_of_Waves_%28Render%29.png/revision/latest?cb=20160629093249", price: 555.55, quantity: 1, description: "This guitar was originally owned by Mikau, a Great Bay rock god! You are so lucky!")
zora_aura.items.create(name: "Hookshot", image: "https://vignette.wikia.nocookie.net/zelda/images/e/ee/Hookshot_%28Ocarina_of_Time%29.png/revision/latest?cb=20090315050430", price: 43.00, quantity: 32, description: "This is a cool tool. Not only is it a possible weapon against monsters, but it can carry you through the air, if you can find something to grab it with.")
zora_aura.items.create(name: "Boomerang", image: "https://vignette.wikia.nocookie.net/zelda/images/7/7b/Boomerang_%28Ocarina_of_Time%29.png/revision/latest?cb=20100328014014", price: 18.99, quantity: 32, description: "It's a boomerang. It comes back to you after you throw it. It's a toy... or a weapon!")
zora_aura.items.create(name: "Fish", image: "https://vignette.wikia.nocookie.net/zelda/images/d/d9/Ocarina_of_Time_Fish_Bass_%28Render%29.png/revision/latest?cb=20160516013558", price: 1.0, quantity: 989, description: "It's a fish. This is a river.")

lakeside_concessions.items.create(name: "Fishing Rod", image: "https://vignette.wikia.nocookie.net/zelda/images/1/17/Majora%27s_Mask_3D_Fishing_Rod_%28Standard_Lure%29.png/revision/latest?cb=20160206010444", price: 14.0, quantity: 21, description: "for fishin'")
lakeside_concessions.items.create(name: "Silver Scale", image: "https://vignette.wikia.nocookie.net/zelda/images/6/6a/Silver_Scale.png/revision/latest?cb=20091009213402", price: 34.0, quantity: 22, description: "This can help you dive faster and longer than ever before. Exciting!")
lakeside_concessions.items.create(name: "Fish", image: "https://vignette.wikia.nocookie.net/zelda/images/d/d9/Ocarina_of_Time_Fish_Bass_%28Render%29.png/revision/latest?cb=20160516013558", price: 1.0, quantity: 890, description: "It's a fish. This is a lake.")
lakeside_concessions.items.create(name: "Blue Tunic", image: "https://vignette.wikia.nocookie.net/zelda/images/9/98/Zora_Tunic_Artwork.png/revision/latest?cb=20091009212907", price: 55.0, quantity: 45, description: "This tunic can help you breathe underwater like a zora! Pretty cool right? Especially if you happen to have iron boots.")
lakeside_concessions.items.create(name: "Popcorn", image: "https://www.100daysofrealfood.com/wp-content/uploads/2011/06/popcorn1-378x500.webp", price: 3.0, quantity: 88, description: "For if you get hungry at the lake.")

stolen_goods.items.create(name: "Some Guy's Wallet", image: "https://wisebread-killeracesmedia.netdna-ssl.com/files/fruganomics/imagecache/605w/blog-images/wallet-with-money.jpg", price: 989.00, quantity: 1, description: "It has 20 bucks in it. Sure, it came from someone else. Why do you ask? We are thieves after all.")
stolen_goods.items.create(name: "Silver Gauntlets", image: "https://vignette.wikia.nocookie.net/zelda/images/5/5c/Silver_Gauntlets.png/revision/latest?cb=20090417202554", price: 141.12, quantity: 32, description: "This is awesome for lifting up heavy rocks and pushing heavy stones. But it's technically cheating in the NFL.")
stolen_goods.items.create(name: "Mirror Shield", image: "https://vignette.wikia.nocookie.net/zelda/images/0/0c/Mirror_Shield_%28Master_Quest%29.png/revision/latest?cb=20110514184338", price: 88.0, quantity: 4, description: "These mirror shield are limited in stock, but they are really cool. They reflect sunlight and evil witch magic.")
stolen_goods.items.create(name: "Bombchus", image: "https://vignette.wikia.nocookie.net/zelda/images/4/47/Bombchu_%28Ocarina_of_Time%29.png/revision/latest?cb=20090317233712", price: 20.0, quantity: 68, description: "These are bombs that look like Pikachu and chase after you. Use with caution! But dang they are helpful in a complicated dungeon!")
stolen_goods.items.create(name: "Fire Arrows", image: "https://vignette.wikia.nocookie.net/zelda/images/1/10/Majora%27s_Mask_Arrows_Fire_Arrow_%28Artwork%29.png/revision/latest?cb=20160529223515", price: 33.33, quantity: 45, description: "These are fire arrows. They are like arrows... but on fire. Very useful for combat! Don't shoot innocent people!")

temple_of_time_gift_shop.items.create(name: "Ocarina of Time", image: "https://vignette.wikia.nocookie.net/zelda/images/9/94/Ocarina_of_Time.png/revision/latest?cb=20091217211756", price: 456.00, quantity: 1, description: "This is a great ocarina if you like music (or time travel). Fun fact: The Hero of Time used this Ocarina to save the world and traveled through time in a strangely limited way.")
temple_of_time_gift_shop.items.create(name: "Triforce", image: "https://vignette.wikia.nocookie.net/zelda/images/d/d5/Triforce_%28A_Link_to_the_Past%29.png/revision/latest?cb=20100329024633", price: 99999.99, quantity: 1, description: "This will give the user that possesses it ultimate power over the world... But if you are not worthy it will split up into three pieces and the other two will be given to your enemies. It belongs in a museum!")
temple_of_time_gift_shop.items.create(name: "Lens of Truth", image: "https://vignette.wikia.nocookie.net/zelda/images/8/83/Lens_of_Truth.png/revision/latest?cb=20090807230220", price: 67.00 , quantity: 1, description: "It's a monocle, I think. But it's cool! You can see ghosts! And through some walls... that aren't really there? I'm not sure I understand.")
temple_of_time_gift_shop.items.create(name: "Mask of Truth", image: "https://vignette.wikia.nocookie.net/zelda/images/3/32/Mask_of_Truth_%28Majora%27s_Mask%29.png/revision/latest?cb=20090724233732", price: 500.00, quantity: 1, description: "If you want to talk to stone statues around hyrule and not just get the time... this is the mask for you.")
temple_of_time_gift_shop.items.create(name: "Majora's Mask", image: "https://vignette.wikia.nocookie.net/zelda/images/6/6f/Majora%27s_Mask_Artwork.png/revision/latest?cb=20100531010717", price: 999.99, quantity: 1, description: "Don't buy this mask. It is evil. Once, it possessed a forest kid and summoned the moon to destroy a town. I don't even know why we're selling it.")

tingles_maps.items.create(name: "Map of Clock Town", image: "https://vignette.wikia.nocookie.net/zelda/images/6/66/Dungeon_Map_%28The_Wind_Waker%29.png/revision/latest?cb=20090805235944", price: 9.99, quantity: 21, description: "Its a map... of Clock Town")
tingles_maps.items.create(name: "Map of Great Bay", image: "https://vignette.wikia.nocookie.net/zelda/images/6/66/Dungeon_Map_%28The_Wind_Waker%29.png/revision/latest?cb=20090805235944", price: 9.99, quantity: 12, description: "Its a map... of Great Bay")
tingles_maps.items.create(name: "Map of Southern Swamp", image: "https://vignette.wikia.nocookie.net/zelda/images/6/66/Dungeon_Map_%28The_Wind_Waker%29.png/revision/latest?cb=20090805235944", price: 9.99, quantity: 13, description: "Its a map... of Southern Swamp")
tingles_maps.items.create(name: "Map of Snowhead Mountain", image: "https://vignette.wikia.nocookie.net/zelda/images/6/66/Dungeon_Map_%28The_Wind_Waker%29.png/revision/latest?cb=20090805235944", price: 9.99, quantity: 14, description: "Its a map... of Snowhead Mountain")
tingles_maps.items.create(name: "Map of Ikana Canyon", image: "https://vignette.wikia.nocookie.net/zelda/images/6/66/Dungeon_Map_%28The_Wind_Waker%29.png/revision/latest?cb=20090805235944", price: 9.99, quantity: 23, description: "Its a map... of Ikana Canyon")

toads_market.items.create(name: "Green Mushroom", image: "https://www.mariowiki.com/images/thumb/b/b4/1-Up_Mushroom_Artwork_-_Super_Mario_3D_World.png/1200px-1-Up_Mushroom_Artwork_-_Super_Mario_3D_World.png", price: 234.89, quantity: 32, description: "This mushroom will literally give you an extra life. You never know when another life will come in handy.")
toads_market.items.create(name: "Red Mushroom", image: "https://www.mariowiki.com/images/thumb/a/a6/Super_Mushroom_Artwork_-_Super_Mario_3D_World.png/1200px-Super_Mushroom_Artwork_-_Super_Mario_3D_World.png", price: 127.83, quantity: 78, description: "This mushroom is special. It makes you grow large in size and will keep you from dying until you shrink, which will happen if you get hurt.")
toads_market.items.create(name: "Star", image: "https://www.mariowiki.com/images/thumb/8/8a/New_Super_Mario_Bros._U_Deluxe_Super_Star.png/1200px-New_Super_Mario_Bros._U_Deluxe_Super_Star.png", price: 100.0, quantity: 77, description: "This star is super! It will make you invincible for a short period of time. It will also always play the same song for the duration of your invincibility.")
toads_market.items.create(name: "Coin", image: "https://www.mariowiki.com/images/thumb/1/17/CoinMK8.png/996px-CoinMK8.png", price: 0.01, quantity: 9999, description: "This is a coin. Shipping not included.")
toads_market.items.create(name: "Fire Flower", image: "https://www.mariowiki.com/images/thumb/7/7e/New_Super_Mario_Bros._U_Deluxe_Fire_Flower.png/1170px-New_Super_Mario_Bros._U_Deluxe_Fire_Flower.png", price: 25.0, quantity: 17, description: "This fire flower is useful for growing into a giant and shooting fireballs at goombas. 'Nuff said.'")

koopa_troopa_exchange.items.create(name: "Green Shell", image: "https://www.mariowiki.com/images/9/94/GreenShell_-_MarioPartyStarRush.png", price: 4.0, quantity: 56, description: "This is a shell used to knock people off of their path in a race.")
koopa_troopa_exchange.items.create(name: "Red Shell", image: "https://www.mariowiki.com/images/thumb/9/95/RedShellMK8.png/1394px-RedShellMK8.png", price: 7.0, quantity: 22, description: "This is a shell used to knock people off of their path in a race, but it has a homing feature, as well.")
koopa_troopa_exchange.items.create(name: "Blue Shell", image: "https://www.mariowiki.com/images/1/1b/ShellNSMB.png", price: 10.0, quantity: 5, description: "This shell is particular useful in a cart race. It will find and 'take out' anyone who is in first place, so...")




puts 'seed data finished'
puts "Users created: #{User.count.to_i}"
puts "Orders created: #{Order.count.to_i}"
puts "Items created: #{Item.count.to_i}"
puts "OrderItems created: #{OrderItem.count.to_i}"
