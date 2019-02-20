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

#Users
create(:admin, name: 'Admin', email: 'admin@gmail.com')
user_1 = create(:user, name: 'Link', address: '245 Stroop Hill Road', city: 'Madison', state: 'Wisconsin', zipcode: 53558 )
user_2 = create(:user, name: 'Mario', address: '4764 Bombardier Way', city: 'Wausau', state: 'Wisconsin', zipcode: 54401 )
user_3 = create(:user, name: 'Kirby', address: '2281 Cambridge Court', city: 'Denver', state: 'Colorado', zipcode: 80203 )
user_4 = create(:user, name: 'Samus', address: '3691 Valley View Drive', city: 'Seattle', state: 'Washington', zipcode: 98101 )
user_5 = create(:user, name: 'Fox', address: '155 Eagle Drive', city: 'Springfield', state: 'Missouri', zipcode: 65619 )
user_6 = create(:user, name: 'Captain Falcon', address: '1616 Irving Road', city: 'Springfield', state: 'Colorado', zipcode: 81073 )

#Merchants
atari = create(:merchant, name: 'Atari', email: 'atari@gmail.com', city: 'Sunnyvale', state: 'California')
nintendo = create(:merchant, name: 'Nintendo', email: 'nintendo@gmail.com', city: 'Redmond', state: 'Washington')
sega = create(:merchant, name: 'Sega', email: 'sega@gmail.com', city: 'Irvine', state: 'California')
sony = create(:merchant, name: 'Sony', email: 'sony@gmail.com', city: 'New York', state: 'New York')
microsoft = create(:merchant, name: 'Microsoft', email: 'microsoft@gmail.com', city: 'Redmond', state: 'Washington')

Random.new_seed
rng = Random.new

#Items
atari_7800 = create(:item, user: atari, name: 'Atari 7800', image: 'https://upload.wikimedia.org/wikipedia/commons/6/6a/Atari_7800_with_cartridge.jpg', price: 149.99, quantity: rng.rand(10), description: 'The Atari 7800 ProSystem, or simply the Atari 7800, is a home video game console officially released by the Atari Corporation in 1986. It is almost fully backward-compatible with the Atari 2600, the first console to have backward compatibility without the use of additional modules.')
atari_jaguar = create(:item, user: atari, name: 'Atari Jaguar', image: 'https://upload.wikimedia.org/wikipedia/commons/5/57/Atari_Jaguar_console.jpg', price: 129.99, quantity: rng.rand(10), description: 'The Atari Jaguar is a home video game console that was developed by Atari Corporation. The console is the sixth programmable console to be developed under the Atari brand, originally released in North America in November 1993. It is also the last Atari console to use physical media.')
nintendo_nes = create(:item, user: nintendo, name: 'Nintendo Entertainment System', image: 'https://upload.wikimedia.org/wikipedia/commons/8/8a/Nintendo_entertainment_system.jpeg', price: 89.99, quantity: rng.rand(10), description: 'The Nintendo Entertainment System (or NES for short) is an 8-bit home video game console developed and manufactured by Nintendo. It is a remodeled export version of the company\'s Family Computer (FC) platform in Japan, also known as the Famicom for short, which launched on July 15, 1983.')
nintendo_snes = create(:item, user: nintendo, name: 'Super Nintendo Entertainment System', image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/31/SNES-Mod1-Console-Set.jpg/1920px-SNES-Mod1-Console-Set.jpg', price: 79.99, quantity: rng.rand(10), description: 'The Super Nintendo Entertainment System (SNES), also known as the Super NES or Super Nintendo, is a 16-bit home video game console developed by Nintendo that was released in 1990 in Japan and South Korea, 1991 in North America, 1992 in Europe and Australasia (Oceania), and 1993 in South America.')
nintendo_64 = create(:item, user: nintendo, name: 'Nintendo 64', image: 'https://upload.wikimedia.org/wikipedia/commons/7/7b/Nintendo_64_with_Mario_Kart_64_cartridge_20040725.jpg', price: 84.99, quantity: rng.rand(10), description: 'The Nintendo 64, stylized as NINTENDO64 and abbreviated as N64, is Nintendo\'s third home video game console for the international market. Named for its 64-bit central processing unit, it was released in June 1996 in Japan, September 1996 in North America and Brazil, March 1997 in Europe and Australia, and September 1997 in France.')
nintendo_gamecube = create(:item, user: nintendo, name: 'Nintendo GameCube', image: 'https://upload.wikimedia.org/wikipedia/commons/d/d1/GameCube-Set.jpg', price: 89.99, quantity: rng.rand(10), description: 'The Nintendo GameCube, abbreviated NGC in Japan and GCN in Europe and North America, is a home video game console released by Nintendo in Japan and North America in 2001 and Europe and Australia in 2002. The sixth generation console is the successor to the Nintendo 64 and competed with Sony\'s PlayStation 2 and Microsoft\'s Xbox.')
sega_master_system = create(:item, user: sega, name: 'Sega Master Sytem', image: 'https://upload.wikimedia.org/wikipedia/commons/9/98/Master_System_II.jpg', price: 99.99, quantity: rng.rand(10), description: 'The Sega Master System (SMS) is a third-generation home video game console manufactured by Sega. It was originally a remodeled export version of the Sega Mark III, the third iteration of the SG-1000 series of consoles, which was released in Japan in 1985 and featured enhanced graphical capabilities over its predecessors.')
sega_genesis = create(:item, user: sega, name: 'Sega Genesis', image: 'https://upload.wikimedia.org/wikipedia/commons/6/6a/Sega-Genesis-Mk2-6button.jpg', price: 49.99, quantity: rng.rand(10), description: 'The Sega Genesis, known as the Mega Drive in regions outside of North America, is a 16-bit home video game console developed and sold by Sega. The Genesis was Sega\'s third console and the successor to the Master System.')
sega_saturn = create(:item, user: sega, name: 'Sega Saturn', image: 'https://upload.wikimedia.org/wikipedia/commons/8/87/Sega_Saturn_Console.png', price: 59.99, quantity: rng.rand(10), description: 'The Sega Saturn is a 32-bit fifth-generation home video game console developed by Sega and released on November 22, 1994 in Japan, May 11, 1995 in North America, and July 8, 1995 in Europe. The successor to the successful Sega Genesis, the Saturn has a dual-CPU architecture and eight processors.')
sega_dreamcast = create(:item, user: sega, name: 'Sega Dreamcast', image: 'https://upload.wikimedia.org/wikipedia/commons/2/20/DreamcastConsole.jpg', price: 69.99, quantity: rng.rand(10), description: 'The Dreamcast is a home video game console released by Sega on November 27, 1998 in Japan, September 9, 1999 in North America, and October 14, 1999 in Europe. It was the first in the sixth generation of video game consoles, preceding Sony\'s PlayStation 2, Nintendo\'s GameCube and Microsoft\'s Xbox.')
sony_playstation = create(:item, user: sony, name: 'Sony PlayStation', image: 'https://upload.wikimedia.org/wikipedia/commons/d/d7/Sony-PlayStation-5501-Console-FL.jpg', price: 49.99, quantity: rng.rand(10), description: 'PlayStation is a gaming brand that consists of four home video game consoles, as well as a media center, an online service, a line of controllers, two handhelds and a phone, as well as multiple magazines. It is created and owned by Sony Interactive Entertainment since December 3, 1994, with the launch of the original PlayStation in Japan.')
sony_playstation_2 = create(:item, user: sony, name: 'Sony PlayStation 2', image: 'https://upload.wikimedia.org/wikipedia/commons/7/7b/Sony-PlayStation-2-30001-Console-FL.jpg', price: 49.99, quantity: rng.rand(10), description: 'The PlayStation 2 (PS2) is a home video game console that was developed by Sony Computer Entertainment. It is the successor to the original PlayStation console and is the second iteration in the PlayStation lineup of consoles.')
microsoft_xbox = create(:item, user: microsoft, name: 'Microsoft Xbox', image: 'https://upload.wikimedia.org/wikipedia/commons/f/fa/Xbox-Console-wDuke-R.jpg', price: 49.99, quantity: rng.rand(10), description: 'The Xbox is a home video game console and the first installment in the Xbox series of consoles manufactured by Microsoft. It was released on November 15, 2001 in North America, followed by Australia, Europe and Japan in 2002. It is a sixth generation console, and competed with Sony\'s PlayStation 2 and Nintendo\'s GameCube.')

ms_pac_man = create(:item, user: atari, name: 'Ms. Pac-Man', image: 'https://www.mobygames.com/images/covers/l/31518-ms-pac-man-atari-7800-front-cover.jpg', price: 24.99, quantity: rng.rand(10), description:'Ms. Pac-Man is the second game in the Pac-Man series, released in arcades in February 1982. Ms. Pac-Man introduced a female protagonist, four different mazes, more colorful graphics, and several gameplay changes.')
galaga = create(:item, user: atari, name: 'Galaga', image: 'https://upload.wikimedia.org/wikipedia/en/4/4d/Galaga_flyer.jpg', price: 14.99, quantity: rng.rand(10), description:'Galaga is a Japanese arcade game developed and published by Namco Japan and by Midway in North America in 1981. It is the sequel to 1979\'s Galaxian.')
rayman = create(:item, user: atari, name: 'Rayman', image: 'https://upload.wikimedia.org/wikipedia/en/4/45/Rayman_1_cover.png', price: 179.99, quantity: rng.rand(10), description:'Rayman is a side-scrolling platform video game developed by Ubi Pictures and published by Ubi Soft. The first installment in the Rayman series, the game follows the adventures of Rayman, a hero who must save his colourful world from the evil Mr. Dark.')
wolfenstein = create(:item, user: atari, name: 'Wolfenstein 3D', image: 'https://upload.wikimedia.org/wikipedia/en/0/05/Wolfenstein-3d.jpg', price: 69.99, quantity: rng.rand(10), description:'Wolfenstein 3D is a first-person shooter video game developed by id Software and published by Apogee Software and FormGen. Originally released on May 5, 1992 for MS-DOS, it was inspired by the 1981 Muse Software video game Castle Wolfenstein, and is the third installment in the Wolfenstein series.')
super_mario = create(:item, user: nintendo, name: 'Super Mario Bros.', image: 'https://upload.wikimedia.org/wikipedia/en/0/03/Super_Mario_Bros._box.png', price: 19.99, quantity: rng.rand(10), description:'Super Mario Bros. is a platform video game developed and published by Nintendo. The successor to the 1983 arcade game, Mario Bros., it was released in Japan in 1985 for the Famicom, and in North America and Europe for the Nintendo Entertainment System (NES) in 1985 and 1987 respectively.')
chrono = create(:item, user: nintendo, name: 'Chrono Trigger', image: 'https://upload.wikimedia.org/wikipedia/en/a/a7/Chrono_Trigger.jpg', price: 99.99, quantity: rng.rand(10), description:'Chrono Trigger is a role-playing video game developed and published by Square for the Super Nintendo Entertainment System in 1995. Chrono Trigger was a critical and commercial success upon release, and is frequently cited as one of the best video games of all time.')
smash_64 = create(:item, user: nintendo, name: 'Super Smash Bros.', image: 'https://upload.wikimedia.org/wikipedia/en/4/42/Supersmashbox.jpg', price: 39.99, quantity: rng.rand(10), description:'Super Smash Bros. is a crossover fighting video game developed by HAL Laboratory and published by Nintendo for the Nintendo 64. It was first released in Japan on January 21, 1999, in North America on April 26, 1999, and in Europe on November 19, 1999.')
ocarina = create(:item, user: nintendo, name: 'The Legend of Zelda: Ocarina of Time', image: 'https://upload.wikimedia.org/wikipedia/en/8/8e/The_Legend_of_Zelda_Ocarina_of_Time_box_art.png', price: 39.99, quantity: rng.rand(10), description: 'The Legend of Zelda: Ocarina of Time is an action-adventure game developed and published by Nintendo for the Nintendo 64. It was released in Japan and North America in November 1998, and in Europe and Australia the following month.')
melee = create(:item, user: nintendo, name: 'Super Smash Bros. Melee', image: 'https://upload.wikimedia.org/wikipedia/en/7/75/Super_Smash_Bros_Melee_box_art.png', price: 39.99, quantity: rng.rand(10), description:'Super Smash Bros. Melee is a crossover fighting video game developed by HAL Laboratory and published by Nintendo for the GameCube. It was first released in Japan on November 21, 2001, in North America on December 3, 2001, in Europe on May 24, 2002, and in Australia on May 31, 2002.')
double_dragon = create(:item, user: sega, name: 'Double Dragon', image: 'https://upload.wikimedia.org/wikipedia/en/e/e6/Ddragon_chirashi.jpg', price: 14.99, quantity: rng.rand(10), description:'Double Dragon is a 1987 beat \'em up video game developed by Technōs Japan and distributed in North America and Europe by Taito. The game is a spiritual and technological successor to Technos\' earlier beat \'em up, Nekketsu Kōha Kunio-kun, but introduced several additions such as two-player cooperative gameplay and the ability to arm oneself with an enemy\'s weapon after disarming them.')
doom = create(:item, user: sega, name: 'DOOM', image: 'https://upload.wikimedia.org/wikipedia/en/5/57/Doom_cover_art.jpg', price: 29.99, quantity: rng.rand(10), description: 'Doom is a 1993 first-person shooter (FPS) video game by id Software. It is considered one of the most significant and influential titles in video game history, for having helped to pioneer the now-ubiquitous first-person shooter.')
sonic = create(:item, user: sega, name: 'Sonic the Hedgehog', image: 'https://upload.wikimedia.org/wikipedia/en/b/ba/Sonic_the_Hedgehog_1_Genesis_box_art.jpg', price: 9.99, quantity: rng.rand(10), description: 'Sonic the Hedgehog, also referred to as Sonic 1, is a platform game developed by Sonic Team and published by Sega for the Sega Genesis console. It was released in North America in June 1991, and in PAL regions and Japan the following month.')
final_fantasy = create(:item, user: sony, name: 'Final Fantasy VII', image: 'https://upload.wikimedia.org/wikipedia/en/c/c2/Final_Fantasy_VII_Box_Art.jpg', price: 14.99, quantity: rng.rand(10), description:'Final Fantasy VII is a 1997 role-playing video game developed by Square for the PlayStation console. It is the seventh main installment in the Final Fantasy series. Published in Japan by Square, it was released in other regions by Sony Computer Entertainment and became the first in the main series to see a PAL release.')
ratchet = create(:item, user: sony, name: 'Ratchet and Clank', image: 'https://upload.wikimedia.org/wikipedia/en/b/b6/RaCbox.jpg', price: 9.99, quantity: rng.rand(10), description:'Ratchet & Clank is a 2002 3D platform video game developed by Insomniac Games and published by Sony Computer Entertainment for the PlayStation 2. Ratchet & Clank is the first game in the series and precedes Going Commando.')
jak = create(:item, user: sony, name: 'Jak and Daxter: The Precursor Legacy', image: 'https://upload.wikimedia.org/wikipedia/en/b/b6/Jak_and_Daxter_-_The_Precursor_Legacy_Coverart.png', price: 4.99, quantity: rng.rand(10), description:'Jak and Daxter: The Precursor Legacy is a 2001 open world platform video game developed by Naughty Dog and published by Sony Computer Entertainment for the Sony PlayStation 2 on December 3, 2001, as the first game of the Jak and Daxter series.')
halo = create(:item, user: microsoft, name: 'Halo: Combat Evolved', image: 'https://upload.wikimedia.org/wikipedia/en/8/80/Halo_-_Combat_Evolved_%28XBox_version_-_box_art%29.jpg', price: 4.99, quantity: rng.rand(10), description:'Halo: Combat Evolved is a 2001 military science fiction first-person shooter video game developed by Bungie and published by Microsoft Game Studios. It was released as a launch title for Microsoft\'s Xbox video game console on November 15, 2001.')
kotor = create(:item, user: microsoft, name: 'Star Wars: Knights of the Old Republic', image: 'https://upload.wikimedia.org/wikipedia/en/1/11/Kotorbox.jpg', price: 9.99, quantity: rng.rand(10), description:'Star Wars: Knights of the Old Republic is a role-playing video game set in the Star Wars universe. Developed by BioWare and published by LucasArts, the game was released for the Xbox on July 15, 2003, and for Microsoft Windows on November 19, 2003.')

order = create(:completed_order, user: user_1)
create(:fulfilled_order_item, order: order, item: nintendo_64, unit_price: nintendo_64.price, quantity: 1, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)
create(:fulfilled_order_item, order: order, item: ocarina, unit_price: ocarina.price, quantity: 1, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)
create(:fulfilled_order_item, order: order, item: melee, unit_price: melee.price, quantity: 2, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)

order = create(:order, user: user_1)
create(:order_item, order: order, item: sega_saturn, unit_price: sega_saturn.price, quantity: 1)
create(:fulfilled_order_item, order: order, item: double_dragon, unit_price: double_dragon.price, quantity: 1, created_at: (rng.rand(6)+1).days.ago, updated_at: rng.rand(23).hours.ago)

order = create(:cancelled_order, user: user_1)
create(:order_item, order: order, item: sony_playstation, unit_price: sony_playstation.price, quantity: 1, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)

order = create(:completed_order, user: user_1)
create(:fulfilled_order_item, order: order, item: wolfenstein, unit_price: wolfenstein.price, quantity: 1, created_at: (rng.rand(6)+1).days.ago, updated_at: rng.rand(59).minutes.ago)
create(:fulfilled_order_item, order: order, item: ms_pac_man, unit_price: ms_pac_man.price, quantity: 1, created_at: (rng.rand(6)+1).days.ago, updated_at: rng.rand(59).minutes.ago)

order = create(:completed_order, user: user_1)
create(:fulfilled_order_item, order: order, item: ms_pac_man, unit_price: ms_pac_man.price, quantity: 1, created_at: (rng.rand(6)+1).days.ago, updated_at: rng.rand(59).minutes.ago)
create(:fulfilled_order_item, order: order, item: galaga, unit_price: galaga.price, quantity: 1, created_at: (rng.rand(6)+1).days.ago, updated_at: rng.rand(59).minutes.ago)

order = create(:completed_order, user: user_2)
create(:fulfilled_order_item, order: order, item: microsoft_xbox, unit_price: microsoft_xbox.price, quantity: 1, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)
create(:fulfilled_order_item, order: order, item: halo, unit_price: halo.price, quantity: 3, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)
create(:fulfilled_order_item, order: order, item: kotor, unit_price: kotor.price, quantity: 1, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)
create(:fulfilled_order_item, order: order, item: final_fantasy, unit_price: final_fantasy.price, quantity: 1, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)
create(:fulfilled_order_item, order: order, item: ratchet, unit_price: ratchet.price, quantity: 1, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)

order = create(:completed_order, user: user_2)
create(:fulfilled_order_item, order: order, item: nintendo_nes, unit_price: nintendo_nes.price, quantity: 1, created_at: (rng.rand(6)+1).days.ago, updated_at: rng.rand(59).minutes.ago)
create(:fulfilled_order_item, order: order, item: super_mario, unit_price: super_mario.price, quantity: 2, created_at: (rng.rand(6)+1).days.ago, updated_at: rng.rand(59).minutes.ago)

order = create(:order, user: user_2)
create(:order_item, order: order, item: atari_7800, unit_price: atari_7800.price, quantity: 1)
create(:order_item, order: order, item: ms_pac_man, unit_price: ms_pac_man.price, quantity: 1)
create(:fulfilled_order_item, order: order, item: wolfenstein, unit_price: wolfenstein.price, quantity: 1, created_at: (rng.rand(6)+1).days.ago, updated_at: rng.rand(59).minutes.ago)


order = create(:completed_order, user: user_3)
create(:fulfilled_order_item, order: order, item: rayman, unit_price: rayman.price, quantity: 1, created_at: (rng.rand(6)+1).days.ago, updated_at: rng.rand(59).minutes.ago)

order = create(:completed_order, user: user_3)
create(:fulfilled_order_item, order: order, item: nintendo_snes, unit_price: nintendo_snes.price, quantity: 2, created_at: (rng.rand(6)+1).days.ago, updated_at: rng.rand(59).minutes.ago)
create(:fulfilled_order_item, order: order, item: chrono, unit_price: chrono.price, quantity: 1, created_at: (rng.rand(6)+1).days.ago, updated_at: rng.rand(59).minutes.ago)

order = create(:completed_order, user: user_3)
create(:fulfilled_order_item, order: order, item: ocarina, unit_price: ocarina.price, quantity: 2, created_at: (rng.rand(6)+1).days.ago, updated_at: rng.rand(59).minutes.ago)

order = create(:completed_order, user: user_3)
create(:fulfilled_order_item, order: order, item: sony_playstation, unit_price: sony_playstation.price, quantity: 2, created_at: (rng.rand(6)+1).days.ago, updated_at: rng.rand(59).minutes.ago)


order = create(:completed_order, user: user_4)
create(:fulfilled_order_item, order: order, item: nintendo_gamecube, unit_price: nintendo_gamecube.price, quantity: 1, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)
create(:fulfilled_order_item, order: order, item: melee, unit_price: melee.price, quantity: 3, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)

order = create(:completed_order, user: user_4)
create(:fulfilled_order_item, order: order, item: sony_playstation_2, unit_price: sony_playstation_2.price, quantity: 1, created_at: (rng.rand(6)+1).days.ago, updated_at: rng.rand(59).minutes.ago)
create(:fulfilled_order_item, order: order, item: ratchet, unit_price: ratchet.price, quantity: 1, created_at: (rng.rand(6)+1).days.ago, updated_at: rng.rand(59).minutes.ago)
create(:fulfilled_order_item, order: order, item: jak, unit_price: jak.price, quantity: 1, created_at: (rng.rand(6)+1).days.ago, updated_at: rng.rand(59).minutes.ago)
create(:fulfilled_order_item, order: order, item: microsoft_xbox, unit_price: microsoft_xbox.price, quantity: 1, created_at: (rng.rand(6)+1).days.ago, updated_at: rng.rand(59).minutes.ago)
create(:fulfilled_order_item, order: order, item: halo, unit_price: halo.price, quantity: 2, created_at: (rng.rand(6)+1).days.ago, updated_at: rng.rand(59).minutes.ago)


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

order = create(:completed_order, user: user_5)
create(:fulfilled_order_item, order: order, item: sony_playstation_2, unit_price: sony_playstation_2.price, quantity: 1, created_at: (rng.rand(6)+1).days.ago, updated_at: rng.rand(59).minutes.ago)
create(:fulfilled_order_item, order: order, item: final_fantasy, unit_price: final_fantasy.price, quantity: 1, created_at: (rng.rand(6)+1).days.ago, updated_at: rng.rand(59).minutes.ago)
create(:fulfilled_order_item, order: order, item: jak, unit_price: jak.price, quantity: 1, created_at: (rng.rand(6)+1).days.ago, updated_at: rng.rand(59).minutes.ago)


order = create(:completed_order, user: user_6)
create(:fulfilled_order_item, order: order, item: sega_dreamcast, unit_price: sega_dreamcast.price, quantity: 1, created_at: (rng.rand(6)+1).days.ago, updated_at: rng.rand(59).minutes.ago)
create(:fulfilled_order_item, order: order, item: sonic, unit_price: sonic.price, quantity: 1, created_at: (rng.rand(6)+1).days.ago, updated_at: rng.rand(59).minutes.ago)

order = create(:completed_order, user: user_6)
create(:fulfilled_order_item, order: order, item: microsoft_xbox, unit_price: microsoft_xbox.price, quantity: 1, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)

order = create(:completed_order, user: user_6)
create(:fulfilled_order_item, order: order, item: kotor, unit_price: kotor.price, quantity: 1, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)
create(:fulfilled_order_item, order: order, item: halo, unit_price: halo.price, quantity: 1, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)

puts 'seed data finished'
puts "Users created: #{User.count.to_i}"
puts "Orders created: #{Order.count.to_i}"
puts "Items created: #{Item.count.to_i}"
puts "OrderItems created: #{OrderItem.count.to_i}"
