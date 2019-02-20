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
#Game Companies
atari = create(:merchant, name: 'Atari')
nintendo = create(:merchant, name: 'Nintendo')
sega = create(:merchant, name: 'Sega')
sony = create(:merchant, name: 'Sony')
microsoft = create(:merchant, name: 'Microsoft')

#Game Consoles
atari_7800 = create(:item, user: atari, name: 'Atari 7800', image: 'https://upload.wikimedia.org/wikipedia/commons/6/6a/Atari_7800_with_cartridge.jpg', price: 149.99, quantity: 10, description: 'The Atari 7800 ProSystem, or simply the Atari 7800, is a home video game console officially released by the Atari Corporation in 1986. It is almost fully backward-compatible with the Atari 2600, the first console to have backward compatibility without the use of additional modules.')
atari_jaguar = create(:item, user: atari, name: 'Atari Jaguar', image: 'https://upload.wikimedia.org/wikipedia/commons/5/57/Atari_Jaguar_console.jpg', price: 129.99, quantity: 10, description: 'The Atari Jaguar is a home video game console that was developed by Atari Corporation. The console is the sixth programmable console to be developed under the Atari brand, originally released in North America in November 1993. It is also the last Atari console to use physical media.')
nintendo_nes = create(:item, user: nintendo, name: 'Nintendo Entertainment System', image: 'https://upload.wikimedia.org/wikipedia/commons/8/8a/Nintendo_entertainment_system.jpeg', price: 89.99, quantity: 10, description: 'The Nintendo Entertainment System (or NES for short) is an 8-bit home video game console developed and manufactured by Nintendo. It is a remodeled export version of the company\'s Family Computer (FC) platform in Japan, also known as the Famicom for short, which launched on July 15, 1983.')
nintendo_snes = create(:item, user: nintendo, name: 'Super Nintendo Entertainment System', image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/31/SNES-Mod1-Console-Set.jpg/1920px-SNES-Mod1-Console-Set.jpg', price: 79.99, quantity: 10, description: 'The Super Nintendo Entertainment System (SNES), also known as the Super NES or Super Nintendo, is a 16-bit home video game console developed by Nintendo that was released in 1990 in Japan and South Korea, 1991 in North America, 1992 in Europe and Australasia (Oceania), and 1993 in South America.')
nintendo_64 = create(:item, user: nintendo, name: 'Nintendo 64', image: 'https://upload.wikimedia.org/wikipedia/commons/7/7b/Nintendo_64_with_Mario_Kart_64_cartridge_20040725.jpg', price: 84.99, quantity: 10, description: 'The Nintendo 64, stylized as NINTENDO64 and abbreviated as N64, is Nintendo\'s third home video game console for the international market. Named for its 64-bit central processing unit, it was released in June 1996 in Japan, September 1996 in North America and Brazil, March 1997 in Europe and Australia, and September 1997 in France.')
nintendo_gamecube = create(:item, user: nintendo, name: 'Nintendo GameCube', image: 'https://upload.wikimedia.org/wikipedia/commons/d/d1/GameCube-Set.jpg', price: 89.99, quantity: 10, description: 'The Nintendo GameCube, abbreviated NGC in Japan and GCN in Europe and North America, is a home video game console released by Nintendo in Japan and North America in 2001 and Europe and Australia in 2002. The sixth generation console is the successor to the Nintendo 64 and competed with Sony\'s PlayStation 2 and Microsoft\'s Xbox.')
sega_master_system = create(:item, user: sega, name: 'Sega Master Sytem', image: 'https://upload.wikimedia.org/wikipedia/commons/9/98/Master_System_II.jpg', price: 99.99, quantity: 10, description: 'The Sega Master System (SMS) is a third-generation home video game console manufactured by Sega. It was originally a remodeled export version of the Sega Mark III, the third iteration of the SG-1000 series of consoles, which was released in Japan in 1985 and featured enhanced graphical capabilities over its predecessors.')
sega_genesis = create(:item, user: sega, name: 'Sega Genesis', image: 'https://upload.wikimedia.org/wikipedia/commons/6/6a/Sega-Genesis-Mk2-6button.jpg', price: 49.99, quantity: 10, description: 'The Sega Genesis, known as the Mega Drive in regions outside of North America, is a 16-bit home video game console developed and sold by Sega. The Genesis was Sega\'s third console and the successor to the Master System.')
sega_saturn = create(:item, user: sega, name: 'Sega Saturn', image: 'https://upload.wikimedia.org/wikipedia/commons/8/87/Sega_Saturn_Console.png', price: 59.99, quantity: 10, description: 'The Sega Saturn is a 32-bit fifth-generation home video game console developed by Sega and released on November 22, 1994 in Japan, May 11, 1995 in North America, and July 8, 1995 in Europe. The successor to the successful Sega Genesis, the Saturn has a dual-CPU architecture and eight processors.')
sega_dreamcast = create(:item, user: sega, name: 'Sega Dreamcast', image: 'https://upload.wikimedia.org/wikipedia/commons/2/20/DreamcastConsole.jpg', price: 69.99, quantity: 10, description: 'The Dreamcast is a home video game console released by Sega on November 27, 1998 in Japan, September 9, 1999 in North America, and October 14, 1999 in Europe. It was the first in the sixth generation of video game consoles, preceding Sony\'s PlayStation 2, Nintendo\'s GameCube and Microsoft\'s Xbox.')
sony_playstation = create(:item, user: sony, name: 'Sony PlayStation', image: 'https://upload.wikimedia.org/wikipedia/commons/d/d7/Sony-PlayStation-5501-Console-FL.jpg', price: 49.99, quantity: 10, description: 'PlayStation is a gaming brand that consists of four home video game consoles, as well as a media center, an online service, a line of controllers, two handhelds and a phone, as well as multiple magazines. It is created and owned by Sony Interactive Entertainment since December 3, 1994, with the launch of the original PlayStation in Japan.')
sony_playstation_2 = create(:item, user: sony, name: 'Sony PlayStation 2', image: 'https://upload.wikimedia.org/wikipedia/commons/7/7b/Sony-PlayStation-2-30001-Console-FL.jpg', price: 49.99, quantity: 10, description: 'The PlayStation 2 (PS2) is a home video game console that was developed by Sony Computer Entertainment. It is the successor to the original PlayStation console and is the second iteration in the PlayStation lineup of consoles.')
microsoft_xbox = create(:item, user: microsoft, name: 'Microsoft Xbox', image: 'https://upload.wikimedia.org/wikipedia/commons/f/fa/Xbox-Console-wDuke-R.jpg', price: 49.99, quantity: 10, description: 'The Xbox is a home video game console and the first installment in the Xbox series of consoles manufactured by Microsoft. It was released on November 15, 2001 in North America, followed by Australia, Europe and Japan in 2002. It is a sixth generation console, and competed with Sony\'s PlayStation 2 and Nintendo\'s GameCube.')

#Games
ocarina = create(:item, user: nintendo, name: 'The Legend of Zelda: Ocarina of Time', image: 'https://upload.wikimedia.org/wikipedia/en/8/8e/The_Legend_of_Zelda_Ocarina_of_Time_box_art.png', price: 39.99, quantity: 10, description: 'The Legend of Zelda: Ocarina of Time is an action-adventure game developed and published by Nintendo for the Nintendo 64. It was released in Japan and North America in November 1998, and in Europe and Australia the following month.')
doom = create(:item, user: atari, name: 'DOOM', image: 'https://upload.wikimedia.org/wikipedia/en/5/57/Doom_cover_art.jpg', price: 29.99, quantity: 10, description: 'Doom is a 1993 first-person shooter (FPS) video game by id Software. It is considered one of the most significant and influential titles in video game history, for having helped to pioneer the now-ubiquitous first-person shooter.')
sonic = create(:item, user: sega, name: 'Sonic the Hedgehog', image: 'https://upload.wikimedia.org/wikipedia/en/b/ba/Sonic_the_Hedgehog_1_Genesis_box_art.jpg', price: 9.99, quantity: 10, description: 'Sonic the Hedgehog, also referred to as Sonic 1, is a platform game developed by Sonic Team and published by Sega for the Sega Genesis console. It was released in North America in June 1991, and in PAL regions and Japan the following month.')

Random.new_seed
rng = Random.new

order = create(:completed_order, user: user)
create(:fulfilled_order_item, order: order, item: sega_genesis, unit_price: sega_genesis.price, quantity: 1, created_at: (rng.rand(3)+1).days.ago, updated_at: rng.rand(59).minutes.ago)
create(:fulfilled_order_item, order: order, item: nintendo_64, unit_price: nintendo_64.price, quantity: 1, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)
create(:fulfilled_order_item, order: order, item: ocarina, unit_price: ocarina.price, quantity: 1, created_at: (rng.rand(5)+1).days.ago, updated_at: rng.rand(59).minutes.ago)
create(:fulfilled_order_item, order: order, item: sonic, unit_price: sonic.price, quantity: 1, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)

# pending order
order = create(:order, user: user)
create(:order_item, order: order, item: sega_saturn, unit_price: sega_saturn.price, quantity: 1)
create(:fulfilled_order_item, order: order, item: sega_master_system, unit_price: sega_master_system.price, quantity: 1, created_at: (rng.rand(23)+1).days.ago, updated_at: rng.rand(23).hours.ago)

order = create(:cancelled_order, user: user)
create(:order_item, order: order, item: sony_playstation, unit_price: sony_playstation.price, quantity: 1, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)
create(:order_item, order: order, item: microsoft_xbox, unit_price: microsoft_xbox.price, quantity: 1, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)

order = create(:completed_order, user: user)
create(:fulfilled_order_item, order: order, item: nintendo_64, unit_price: nintendo_64.price, quantity: 1, created_at: (rng.rand(4)+1).days.ago, updated_at: rng.rand(59).minutes.ago)
create(:fulfilled_order_item, order: order, item: ocarina, unit_price: ocarina.price, quantity: 1, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)





puts 'seed data finished'
puts "Users created: #{User.count.to_i}"
puts "Orders created: #{Order.count.to_i}"
puts "Items created: #{Item.count.to_i}"
puts "OrderItems created: #{OrderItem.count.to_i}"
