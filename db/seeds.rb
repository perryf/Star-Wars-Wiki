# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'flickraw'
Alliance.destroy_all
Species.destroy_all
Homeworld.destroy_all
Transportation.destroy_all
Character.destroy_all
Vehicle.destroy_all

FlickRaw.api_key="f438e2d2703a59971491b8810477cd4d"
FlickRaw.shared_secret="b90683848542d236"

rebel = Alliance.create!({
  name: "Rebels",
  img_url: "http://a.dilcdn.com/bl/wp-content/uploads/sites/6/2015/11/rebel-symbol.jpg"
})

imperial = Alliance.create!({
  name: "Imperials",
  img_url: "http://a.dilcdn.com/bl/wp-content/uploads/sites/6/2016/02/imperialseal.jpg"
})

neutral = Alliance.create!({
  name: "Neutral",
  img_url: "https://vignette2.wikia.nocookie.net/starwars/images/9/9e/BibFortuna_Jabba_Ep6.jpg/revision/latest?cb=20080324151350"
})

# Homeworlds Create
61.times do |i|
  begin
    planet = JSON.parse(Swapi.get_planet(i + 1))
  rescue => e
    puts e
  else
    if img_info = flickr.photos.search(tags: "#{planet["name"]}, starwars, planet", tag_mode: "all").first
      img_farm = img_info.farm
      img_server = img_info.server
      img_id = img_info.id
      img_secret = img_info.secret
      img_url = "https://farm#{img_farm}.staticflickr.com/#{img_server}/#{img_id}_#{img_secret}.jpg"
    else
      img_url = ""
    end
    Homeworld.create!({
      name: planet["name"],
      img_url: img_url,
      climate: planet["climate"],
      terrain: planet["terrain"],
      population: planet["population"],
      gravity: planet["gravity"],
      films: planet["films"],
      url: planet["url"]
    })
  end
end

homeworld_unknown = Homeworld.find_by name: "unknown"

#Species Create
37.times do |i|
  begin
    species = JSON.parse(Swapi.get_species(i + 1))
  rescue => e
    puts e
  else
    planet = Homeworld.find_by url: species["homeworld"]
    if planet == nil
      planet = Homeworld.first
    end
    if img_info = flickr.photos.search(tags: "#{species["name"]}, starwars", tag_mode: "all").first
      img_farm = img_info.farm
      img_server = img_info.server
      img_id = img_info.id
      img_secret = img_info.secret
      img_url = "https://farm#{img_farm}.staticflickr.com/#{img_server}/#{img_id}_#{img_secret}.jpg"
    else
      img_url = ""
    end
    Species.create!({
      name: species["name"],
      img_url: img_url,
      designation: species["designation"],
      classification: species["classification"],
      average_height: species["average_height"],
      average_lifespan: species["average_lifespan"],
      skin_colors: species["skin_colors"],
      language: species["languages"],
      films: species["films"],
      url: species["url"],
      homeworld: planet
    })
  end
end

species_unknown = Species.create!({
  name: "unknown",
  homeworld: homeworld_unknown
})

#Vehicles Create
100.times do |i|
  begin
    vehicle = JSON.parse(Swapi.get_vehicle(i + 1))
  rescue => e
    puts e
  else
    if img_info = flickr.photos.search(tags: "#{vehicle["name"]}, starwars", tag_mode: "all").first
      img_farm = img_info.farm
      img_server = img_info.server
      img_id = img_info.id
      img_secret = img_info.secret
      img_url = "https://farm#{img_farm}.staticflickr.com/#{img_server}/#{img_id}_#{img_secret}.jpg"
    else
      img_url = ""
    end
    Vehicle.create!({
      name: vehicle["name"],
      img_url: img_url,
      model: vehicle["model"],
      manufacturer: vehicle["manufacturer"],
      cost_in_credits: vehicle["cost_in_credits"],
      cargo_capacity: vehicle["cargo_capacity"],
      vehicle_class: vehicle["vehicle_class"],
      max_atmosphering_speed: vehicle["max_atmosphering_speed"],
      crew: vehicle["crew"],
      passengers: vehicle["passengers"],
      length: vehicle["length"],
      films: vehicle["films"],
      url: vehicle["url"]
    })
  end
end
#Starships added into vehicles
100.times do |i|
  begin
    vehicle = JSON.parse(Swapi.get_starship(i + 1))
  rescue => e
    puts e
  else
    if img_info = flickr.photos.search(tags: "#{vehicle["name"]}, starwars", tag_mode: "all").first
      img_farm = img_info.farm
      img_server = img_info.server
      img_id = img_info.id
      img_secret = img_info.secret
      img_url = "https://farm#{img_farm}.staticflickr.com/#{img_server}/#{img_id}_#{img_secret}.jpg"
    else
      img_url = ""
    end
    Vehicle.create!({
      name: vehicle["name"],
      img_url: img_url,
      model: vehicle["model"],
      manufacturer: vehicle["manufacturer"],
      cost_in_credits: vehicle["cost_in_credits"],
      cargo_capacity: vehicle["cargo_capacity"],
      vehicle_class: vehicle["vehicle_class"],
      max_atmosphering_speed: vehicle["max_atmosphering_speed"],
      crew: vehicle["crew"],
      passengers: vehicle["passengers"],
      length: vehicle["length"],
      films: vehicle["films"],
      url: vehicle["url"]
    })
  end
end

unknown_vehicle = Vehicle.create!({
  name: "unknown"
})

#Characters Create
characters = []
87.times do |i|
  begin
    person = JSON.parse(Swapi.get_person(i + 1))
  rescue => e
    puts e
  else
    planet = Homeworld.find_by url: person["homeworld"]
    species = Species.find_by url: person["species"]
    if species == nil
      species = species_unknown
    end
    if planet == nil
      planet = homeworld_unknown
    end
    if img_info = flickr.photos.search(tags: "#{person["name"]}, starwars", tag_mode: "all").first
      img_farm = img_info.farm
      img_server = img_info.server
      img_id = img_info.id
      img_secret = img_info.secret
      img_url = "https://farm#{img_farm}.staticflickr.com/#{img_server}/#{img_id}_#{img_secret}.jpg"
    else
      img_url = ""
    end
    characters << Character.create!({
    name: person["name"],
    img_url: img_url,
    birth_year: person["birth_year"],
    height: person["height"],
    mass: person["mass"],
    films: person["films"],
    url: person["url"],
    alliance: neutral,
    homeworld: planet,
    species: species
    })
    #vehicles attached to characters through transportation
    vehicles = Vehicle.where(url: person["vehicles"])
    if vehicles == nil
      vehicles = unknown_vehicle
    end
    vehicles.each do |bike|
      character = Character.find_by name: person["name"]
      Transportation.create!(character: character, vehicle: bike)
    end
    #starships aka vehicles attached to characters through transportation
    vehicles = Vehicle.where(url: person["starships"])
    if vehicles == nil
      vehicles = unknown_vehicle
    end
    vehicles.each do |bike|
      character = Character.find_by name: person["name"]
      Transportation.create!(character: character, vehicle: bike)
    end
  end
end

xwing = Vehicle.find_by name: "X-wing"
xwing.img_url="https://lumiere-a.akamaihd.net/v1/images/open-uri20150608-27674-1uu8j7u_83e38031.jpeg?region=0%2C0%2C1200%2C507"
xwing.save

deathstar = Vehicle.find_by name: "Death Star"
deathstar.img_url = "https://lumiere-a.akamaihd.net/v1/images/Death-Star-I-copy_36ad2500.jpeg?region=0%2C0%2C1600%2C900&width=1200"
deathstar.save

falcon = Vehicle.find_by name: "Millennium Falcon"
falcon.img_url = "https://lumiere-a.akamaihd.net/v1/images/Millennium-Falcon_018ea796.jpeg?region=0%2C1%2C1536%2C864&width=1200"
falcon.save

ywing = Vehicle.find_by name: "Y-wing"
ywing.img_url = "https://lumiere-a.akamaihd.net/v1/images/Y-Wing-Fighter_0e78c9ae.jpeg?region=0%2C0%2C1536%2C864&width=1200"
ywing.save

tiefighter = Vehicle.find_by name: "TIE/LN starfighter"
tiefighter.img_url = "https://lumiere-a.akamaihd.net/v1/images/TIE-Fighter_25397c64.jpeg?region=0%2C1%2C2048%2C1152&width=1200"
tiefighter.save

tiebomber = Vehicle.find_by name: "TIE bomber"
tiebomber.img_url = "https://lumiere-a.akamaihd.net/v1/images/ep5_key_504_6c3982bb.jpeg?region=0%2C67%2C1280%2C720&width=1200"
tiebomber.save

atat = Vehicle.find_by name: "AT-AT"
atat.img_url = "https://lumiere-a.akamaihd.net/v1/images/AT-AT_89d0105f.jpeg?region=214%2C19%2C1270%2C716&width=1200"
atat.save

atst = Vehicle.find_by name: "AT-ST"
atst.img_url = "https://lumiere-a.akamaihd.net/v1/images/e6d_ia_5724_a150e6d4.jpeg?region=124%2C0%2C1424%2C802&width=1200"
atst.save

snowspeeder = Vehicle.find_by name: "Snowspeeder"
snowspeeder.img_url = "https://lumiere-a.akamaihd.net/v1/images/snowspeeder_ef2f9334.jpeg?region=0%2C211%2C2048%2C1154&width=1200"
snowspeeder.save

stardestroyer = Vehicle.find_by name: "Star Destroyer"
stardestroyer.img_url = "https://lumiere-a.akamaihd.net/v1/images/Star-Destroyer_ab6b94bb.jpeg?region=0%2C0%2C1600%2C900&width=1200"
stardestroyer.save

sandcrawler = Vehicle.find_by name: "Sand Crawler"
sandcrawler.img_url = "https://lumiere-a.akamaihd.net/v1/images/databank_sandcrawler_01_169_55acf6cb.jpeg?region=0%2C0%2C1560%2C878&width=1200"
sandcrawler.save

speederbike = Vehicle.find_by name: "Imperial Speeder Bike"
speederbike.img_url = "https://lumiere-a.akamaihd.net/v1/images/databank_speederbike_01_169_c4204c29.jpeg?region=0%2C0%2C1560%2C878&width=1200"
speederbike.save

slave1 = Vehicle.find_by name: "Slave 1"
slave1.img_url = "https://lumiere-a.akamaihd.net/v1/images/databank_slavei_01_169_8dc3102d.jpeg?region=0%2C0%2C1560%2C878&width=1200"
slave1.save

calamari = Vehicle.find_by name: "Calamari Cruiser"
calamari.img_url = "https://lumiere-a.akamaihd.net/v1/images/e6d_ia_2581_47f64de7.jpeg?region=254%2C0%2C1426%2C802&width=1200"
calamari.save

imperialshuttle = Vehicle.find_by name: "Imperial shuttle"
imperialshuttle.img_url = "https://lumiere-a.akamaihd.net/v1/images/veh_ia_1752_040381b2.jpeg?region=0%2C70%2C1280%2C720&width=1200"
imperialshuttle.save

darth = Character.find_by name: "Darth Vader"
darth.alliance = imperial
darth.img_url = "https://lumiere-a.akamaihd.net/v1/images/Darth-Vader_6bda9114.jpeg?region=0%2C23%2C1400%2C785"
darth.bio = "Once a heroic Jedi Knight, Darth Vader was seduced by the dark side of the Force, became a Sith Lord, and led the Empire’s eradication of the Jedi Order. He remained in service of the Emperor -- the evil Darth Sidious -- for decades, enforcing his Master’s will and seeking to crush the fledgling Rebel Alliance. But there was still good in him…"
darth.catch_phrase = "I find your lack of faith disturbing."
darth.save

emperor = Character.find_by name: "Palpatine"
emperor.alliance = imperial
emperor.img_url = "https://lumiere-a.akamaihd.net/v1/images/Emperor-Palpatine_7ac4a10e.jpeg?region=0%2C0%2C1600%2C900&width=1536"
emperor.bio = "Scheming, powerful, and evil to the core, Darth Sidious restored the Sith and destroyed the Jedi Order. Living a double life, Sidious was in fact Palpatine, a Naboo Senator and phantom menace. He slowly manipulated the political system of the Galactic Republic until he was named Supreme Chancellor -- and eventually Emperor -- ruling the galaxy through fear and tyranny."
emperor.catch_phrase = "Young fool... Only now, at the end, do you understand..."
emperor.save

luke = Character.find_by name: "Luke Skywalker"
luke.alliance = rebel
luke.img_url = "https://lumiere-a.akamaihd.net/v1/images/open-uri20150608-27674-1ymefwb_483d5487.jpeg?region=0%2C0%2C1200%2C675"
luke.bio = "Luke Skywalker was a Tatooine farmboy who rose from humble beginnings to become one of the greatest Jedi the galaxy has ever known. Along with his friends Princess Leia and Han Solo, Luke battled the evil Empire, discovered the truth of his parentage, and ended the tyranny of the Sith. A generation later, the location of the famed Jedi master was one of the galaxy’s greatest mysteries."
luke.catch_phrase = "Uncle Owen!"
luke.save

yoda = Character.find_by name: "Yoda"
yoda.alliance = rebel
yoda.img_url = "https://lumiere-a.akamaihd.net/v1/images/Yoda-Retina_2a7ecc26.jpeg?region=0%2C0%2C1536%2C864"
yoda.bio = "Yoda was a legendary Jedi Master and stronger than most in his connection with the Force. Small in size but wise and powerful, he trained Jedi for over 800 years, playing integral roles in the Clone Wars, the instruction of Luke Skywalker, and unlocking the path to immortality."
yoda.catch_phrase = "When nine hundred years old you reach, look as good you will not."
yoda.save

leia = Character.find_by name: "Leia Organa"
leia.alliance = rebel
leia.img_url = "https://lumiere-a.akamaihd.net/v1/images/open-uri20150608-27674-1ly2wd_eb4b4064.jpeg?region=0%2C0%2C1200%2C674"
leia.bio = "Princess Leia Organa was one of the Rebel Alliance’s greatest leaders, fearless on the battlefield and dedicated to ending the tyranny of the Empire. Daughter of Padmé Amidala and Anakin Skywalker, sister of Luke Skywalker, and with a soft spot for scoundrels, Leia ranks among the galaxy’s great heroes. But life under the New Republic has not been easy for Leia. Sidelined by a new generation of political leaders, and struck out on her own to oppose the First Order as founder of the Resistance. These setbacks in her political career have been accompanied by more personal losses."
leia.catch_phrase = "Why, you stuck up, half-witted, scruffy-looking, Nerf-herder!"
leia.save

sly = Character.find_by name: "Sly Moore"
sly.img_url = "https://lumiere-a.akamaihd.net/v1/images/sly-moore_6af90e66.jpeg?region=95%2C133%2C1116%2C628"
sly.alliance = imperial
sly.save

r2d2 = Character.find_by name: "R2-D2"
r2d2.alliance = rebel
r2d2.img_url = "https://lumiere-a.akamaihd.net/v1/images/r2-d2-featured_ba3d1867.jpeg?region=0%2C48%2C1536%2C768&width=1200"
r2d2.bio = "A resourceful astromech droid, R2-D2 served Padmé Amidala, Anakin Skywalker and Luke Skywalker in turn, showing great bravery in rescuing his masters and their friends from many perils. A skilled starship mechanic and fighter pilot's assistant, he formed an unlikely but enduring friendship with the fussy protocol droid C-3PO."
r2d2.save

c3p0 = Character.find_by name: "C-3PO"
c3p0.alliance = rebel
c3p0.img_url = "https://lumiere-a.akamaihd.net/v1/images/C-3PO-See-Threepio_68fe125c.jpeg?region=0%2C1%2C1408%2C792"
c3p0.bio = "C-3PO is a droid programmed for etiquette and protocol, built by the heroic Jedi Anakin Skywalker, and a constant companion to astromech R2-D2. Over the years, he was involved in some of the galaxy’s most defining moments and thrilling battles -- and is fluent in more than seven million forms of communication. In the years after the Empire's defeat, C-3PO acquired a red-plated arm, keeping the mismatched limb to honor a fellow droid's sacrifice."
c3p0.save

han_solo = Character.find_by name: "Han Solo"
han_solo.alliance = rebel
han_solo.img_url = "https://lumiere-a.akamaihd.net/v1/images/open-uri20150608-27674-nfid8t_2aab8189.jpeg?region=0%2C0%2C1200%2C674"
han_solo.bio = "Smuggler. Scoundrel. Hero. Han Solo, captain of the Millennium Falcon, was one of the great leaders of the Rebel Alliance. He and his co-pilot Chewbacca came to believe in the cause of galactic freedom, joining Luke Skywalker and Princess Leia Organa in the fight against the Empire. But after the Battle of Endor, Han would face difficult times in a galaxy plagued by chaos and uncertainty."
han_solo.catch_phrase = "And I thought they smelled bad on the outside"
han_solo.save

chewie = Character.find_by name: "Chewbacca"
chewie.alliance = rebel
chewie.img_url = "https://lumiere-a.akamaihd.net/v1/images/chewie-db_2c0efea2.jpeg?region=54%2C154%2C1413%2C796"
chewie.bio = "A legendary Wookiee warrior and Han Solo’s co-pilot aboard the Millennium Falcon, Chewbacca was part of a core group of Rebels who restored freedom to the galaxy. Known for his short temper and accuracy with a bowcaster, Chewie also has a big heart -- and is unwavering in his loyalty to his friends. He has stuck with Han through years of turmoil that have changed both the galaxy and their lives."
chewie.save

darth_maul = Character.find_by name: "Darth Maul"
darth_maul.alliance = imperial
darth_maul.img_url = "https://lumiere-a.akamaihd.net/v1/images/Darth-Maul_632eb5af.jpeg?region=75%2C42%2C1525%2C858"
darth_maul.bio = "A deadly, agile Sith Lord trained by the evil Darth Sidious, Darth Maul was a formidable warrior and scheming mastermind. He wielded an intimidating double-bladed lightsaber and fought with a menacing ferocity. Though he fell in battle against Obi-Wan Kenobi, the Zabrak from Dathomir would prove to be much harder to destroy than originally believed."
darth_maul.save

ackbar = Character.find_by name: "Ackbar"
ackbar.alliance = rebel
ackbar.catch_phrase = "It's a trap!"
ackbar.img_url="https://lumiere-a.akamaihd.net/v1/images/admiralackbar1_2_845df144.jpeg?region=153%2C0%2C1614%2C807&width=1200"
ackbar.bio = "A veteran commander, Ackbar led the defense of his homeworld, Mon Cala, during the Clone Wars and then masterminded the rebel attack on the second Death Star at the Battle of Endor. Ackbar realized the rebels had been drawn into a trap at Endor, but adjusted, with his fleet buying valuable time for the attack to succeed. After the Battle of Endor, Ackbar became a Grand Admiral in the New Republic, winning many victories including the pivotal Battle of Jakku. He retired to Mon Cala, but was coaxed back into service with the Resistance by Leia Organa."
ackbar.save

owen = Character.find_by name: "Owen Lars"
owen.alliance = rebel
owen.img_url = "https://lumiere-a.akamaihd.net/v1/images/databank_owenlars_01_169_effce0f8.jpeg?region=0%2C0%2C1560%2C878&width=1536"
owen.bio = "Owen Lars continued his father Cliegg’s efforts to build his homestead into a productive farm, working alongside his wife, Beru. Helping with the dreary chores required to keep the farm profitable, Owen relied on his nephew Luke Skywalker. He could not rein in Luke's drive for adventure, though. Young Skywalker longed to leave Tatooine and join the Imperial Academy, to live life among the stars. Owen forbade it, reminding Luke that he was needed on the moisture farm. Skywalker would eventually leave the farm, but under tragic circumstances. Imperials searching for missing droids razed the Lars homestead and killed Owen and Beru."
owen.save

anakin = Character.find_by name: "Anakin Skywalker"
anakin.alliance = rebel
anakin.img_url = "https://lumiere-a.akamaihd.net/v1/images/Anakin-Skywalker_d3330724.jpeg?region=0%2C0%2C1200%2C675"
anakin.bio = "Discovered as a slave on Tatooine by Qui-Gon Jinn and Obi-Wan Kenobi, Anakin Skywalker had the potential to become one of the most powerful Jedi ever, and was believed by some to be the prophesied Chosen One who would bring balance to the Force. A hero of the Clone Wars, Anakin was caring and compassionate, but also had a fear of loss that would prove to be his downfall."
anakin.catch_phrase = "Now this is pod racing!"
anakin.save

jabba = Character.find_by name: "Jabba Desilijic Tiure"
anakin.alliance = neutral
jabba.img_url = "https://lumiere-a.akamaihd.net/v1/images/Jabba-The-Hutt_b5a08a70.jpeg?region=0%2C0%2C1200%2C675"
jabba.bio = "Jabba the Hutt was one of the galaxy’s most powerful gangsters, with far-reaching influence in both politics and the criminal underworld. There were no second chances with Jabba, something Han Solo would find out -- though the slug-like alien would ultimately fall victim to his own hubris and vengeful ways."
jabba.save

boba = Character.find_by name: "Boba Fett"
boba.alliance = neutral
boba.img_url = "https://lumiere-a.akamaihd.net/v1/images/Boba-Fett_61fdadfd.jpeg?region=0%2C0%2C1200%2C675"
boba.bio = "With his customized Mandalorian armor, deadly weaponry, and silent demeanor, Boba Fett was one of the most feared bounty hunters in the galaxy. A genetic clone of his “father,” bounty hunter Jango Fett, Boba learned combat and martial skills from a young age. Over the course of his career, which included contracts for the Empire and the criminal underworld, he became a legend."
boba.save

rey = Character.find_by name: "Rey"
rey.alliance = rebel
rey.img_url = "https://lumiere-a.akamaihd.net/v1/images/rey_bddd0f27.jpeg?region=0%2C24%2C1560%2C876&width=1536"
rey.bio = "Rey is a Jakku scavenger, a survivor toughened by life on a harsh desert planet. When the fugitive droid BB-8 appeals to her for help, Rey finds herself drawn into a galaxy-spanning conflict. Despite dismissing herself as “no one,” she learns that her life is being shaped by the mysterious power of the Force."
rey.save

sebulba = Character.find_by name: "Sebulba"
sebulba.alliance = neutral
sebulba.img_url = "https://lumiere-a.akamaihd.net/v1/images/sebulba_1f3fe180.jpeg?region=0%2C0%2C2453%2C1380&width=1536"
sebulba.save

bib = Character.find_by name: "Bib Fortuna"
bib.alliance = neutral
bib.img_url = "https://lumiere-a.akamaihd.net/v1/images/databank_bibfortuna_01_169_01aef5b7.jpeg?region=0%2C0%2C1560%2C878&width=1536"
bib.bio = "Those attempting to do business with Jabba the Hutt first needed to maneuver past his pasty-faced majordomo, the Twi'lek Bib Fortuna. The darkly robed attendant often hovered near Jabba's ear, offering advice and feeding information. Fortuna followed the rules of protocol in the Hutt's court (such as they were), and spoke only in Huttese, though he understood other tongues. Fortuna's affiliation with Jabba stretched over decades."
bib.save

mace = Character.find_by name: "Mace Windu"
mace.alliance = rebel
mace.img_url = "https://lumiere-a.akamaihd.net/v1/images/Mace-Windu_b35242e5.jpeg?region=0%2C0%2C1637%2C921&width=1536"
mace.bio = "A grim Jedi Master with an amethyst-bladed lightsaber, Mace Windu was the champion of the Jedi Order, with little tolerance for the failings of the Senate, the arguments of politicians, or the opinions of rebellious Jedi. As the Clone Wars intensified, Mace sensed the dark side of the Force at work, and knew the Jedi's enemies were plotting to destroy the Order and end its stewardship of the galaxy."
mace.save

kylo = Character.new
kylo.name = "Kylo Ren"
kylo.alliance = imperial
kylo.img_url = "https://lumiere-a.akamaihd.net/v1/images/kylo-history-4-retina_d8314aec.jpeg?region=0%2C0%2C1200%2C501"
kylo.homeworld = Homeworld.find_by name: "Chandrila"
kylo.species = Species.find_by name: "Human"
kylo.bio = "A dark warrior strong with the Force, Kylo Ren commands First Order missions with a temper as fiery as his unconventional lightsaber. As a leader of the First Order and a student of Supreme Leader Snoke, he seeks to destroy the New Republic, the Resistance and the legacy of the Jedi."
kylo.save

porkins = Character.find_by name: "Jek Tono Porkins"
porkins.alliance = rebel
porkins.img_url = "https://lumiere-a.akamaihd.net/v1/images/jek-porkins-main-image_0b8d2d13.jpeg?region=0%2C0%2C1280%2C721&width=1200"
porkins.catch_phrase = "No, I'm all—Aargh!"
porkins.save

wedge = Character.find_by name: "Wedge Antilles"
wedge.alliance = rebel
wedge.img_url = "https://lumiere-a.akamaihd.net/v1/images/databank_wedgeantilles_01_169_b8185dce.jpeg?region=0%2C0%2C1560%2C878&width=1200"
wedge.bio = "A talented young rebel pilot from Corellia, Wedge Antilles survived the attack on the first Death Star to become a respected veteran of Rogue Squadron. He piloted a snowspeeder in the defense of Echo Base on Hoth, and led Red Squadron in the rebel attack on the second Death Star above Endor."
wedge.save

lando = Character.find_by name: "Lando Calrissian"
lando.alliance = rebel
lando.img_url = "https://lumiere-a.akamaihd.net/v1/images/Lando-Calrissian_a679fe1e.jpeg?region=1%2C0%2C1598%2C899&width=1200"
lando.bio = "Once a smooth-talking smuggler, Lando Calrissian changed from a get-rich-quick schemer to a selfless leader in the fight against the Empire. From adventures with the Ghost crew of rebels to the attack on Death Star II, his quick wit and daring proved to be invaluable."
lando.save

jarjar = Character.find_by name: "Jar Jar Binks"
jarjar.alliance = rebel
jarjar.img_url = "https://lumiere-a.akamaihd.net/v1/images/databank_jarjarbinks_01_169_c70767ab.jpeg?region=0%2C0%2C1560%2C878&width=1200"
jarjar.bio = "A clumsy, well-meaning Gungan outcast on Naboo, Jar Jar Binks struggled to prove his worth throughout his life. Putting his awkward past behind him, Jar Jar left the swamps of Naboo to enter the even murkier waters of Coruscant politics, becoming a representative for his people in the galactic capital. There, his best intentions and eagerness to serve were exploited by scheming Senators and others in positions of power."
jarjar.save

padme = Character.find_by name: "Padmé Amidala"
padme.alliance = rebel
padme.img_url = "https://lumiere-a.akamaihd.net/v1/images/Padme-Amidala_05d50c8a.jpeg?region=0%2C0%2C1536%2C864&width=1200"
padme.bio = "Padmé Amidala was a courageous, hopeful leader, serving as Queen and then Senator of Naboo -- and was also handy with a blaster. Despite her ideals and all she did for the cause of peace, her secret, forbidden marriage to Jedi Anakin Skywalker would prove to have dire consequences for the galaxy."
padme.save

obi = Character.find_by name: "Obi-Wan Kenobi"
obi.alliance = rebel
obi.img_url = "https://lumiere-a.akamaihd.net/v1/images/Obi-Wan-Kenobi_6d775533.jpeg?region=0%2C0%2C1536%2C864&width=1200"
obi.bio = "A legendary Jedi Master, Obi-Wan Kenobi was a noble man and gifted in the ways of the Force. He trained Anakin Skywalker, served as a general in the Republic Army during the Clone Wars, and guided Luke Skywalker as a mentor."
obi.catch_phrase = "May the force be with you"
obi.save

wicket = Character.find_by name: "Wicket Systri Warrick"
wicket.alliance = rebel
wicket.img_url = "https://lumiere-a.akamaihd.net/v1/images/databank_wickettwwarrick_01_169_86d1210c.jpeg?region=0%2C3%2C1560%2C780&width=1536"
wicket.bio = "Wicket W. Warrick was the brave young Ewok who willingly joined the Rebellion and aided in the battle against the Empire on the forest moon of Endor. Even before he encountered the Rebels, Wicket had devised methods for defeating the Imperial machines, plans which were implemented after the Ewok befriended Princess Leia and recruited his tribe to the Alliance's cause. During the Battle of Endor, Wicket fought valiantly alongside his new allies."
wicket.catch_phrase = "Zub Zub!"
wicket.save

grevious = Character.find_by name: "Grievous"
grevious.alliance = imperial
grevious.save

dooku = Character.find_by name: "Dooku"
dooku.alliance = imperial
dooku.save

baris = Character.find_by name: "Barriss Offee"
baris.alliance = rebel
baris.save

nien = Character.find_by name: "Nien Nunb"
nien.alliance = rebel
nien.bio = "A jowled, mouse-eyed native of Sullust, Nien Nunb was an arms dealer and smuggler who piloted the Mellcrawler. After the Battle of Yavin, he helped Princess Leia smuggle an enclave of Alderaanian survivors off Sullust and then assisted the princess during the diversionary mission known as Operation Yellow Moon. Later, Nunb served Lando Calrissian’s co-pilot aboard the Millennium Falcon during the Battle of Endor. He spoke the liquid, chattering tongue of the Sullustans."
nien.save

taun = Character.find_by name: "Taun We"
taun.alliance = imperial
taun.save

ayla = Character.find_by name: "Ayla Secura"
ayla.alliance = rebel
ayla.save

adi = Character.find_by name: "Adi Gallia"
adi.alliance = rebel
ayla.save

tion = Character.find_by name: "Tion Medon"
tion.alliance = imperial
tion.save

bb8 = Character.find_by name: "BB8"
bb8.alliance = rebel
bb8.img_url = "https://lumiere-a.akamaihd.net/v1/images/bb-8_14e2ad77.jpeg?region=0%2C0%2C1560%2C878&width=1536"
bb8.bio = "A skittish but loyal astromech, BB-8 accompanied Poe Dameron on many missions for the Resistance, helping keep his X-wing in working order. When Poe’s mission to Jakku ended with his capture by the First Order, BB-8 fled into the desert with a vital clue to the location of Jedi Master Luke Skywalker."
bb8.save

stormtrooper = Character.new
stormtrooper.name = "Storm Troopers"
stormtrooper.alliance = imperial
stormtrooper.homeworld = homeworld_unknown
stormtrooper.species = Species.find_by name: "Human"
stormtrooper.bio = "Stormtroopers are elite shock troops fanatically loyal to the Empire and impossible to sway from the Imperial cause. They wear imposing white armor, which offers a wide range of survival equipment and temperature controls to allow the soldiers to survive in almost any environment. Stormtroopers wield blaster rifles and pistols with great skill, and attack in hordes to overwhelm their enemies. Along with standard stormtroopers, the Empire has organized several specialized units, including snowtroopers and scout troopers."
stormtrooper.classification = "Military"
stormtrooper.img_url = "https://lumiere-a.akamaihd.net/v1/images/Stormtroopers_f36ff76a.jpeg?region=1%2C0%2C1534%2C863&width=1200"
stormtrooper.save

jawas = Species.new
jawas.name = "Jawas"
jawas.homeworld = Homeworld.find_by name: "Tatooine"
jawas.img_url = "https://lumiere-a.akamaihd.net/v1/images/jawas_42e63e07.jpeg?region=866%2C10%2C1068%2C601"
jawas.average_height = 1
jawas.save

endor = Homeworld.find_by name: "Endor"
endor.img_url = "https://lumiere-a.akamaihd.net/v1/images/databank_endor_01_169_68ba9bdc.jpeg?region=0%2C0%2C1560%2C878&width=1536"
endor.bio = "Secluded in a remote corner of the galaxy, the forest moon of Endor would easily have been overlooked by history were it not for the decisive battle that occurred there. The lush, forest home of the Ewok species is the gravesite of Darth Vader and the Empire itself. It was here that the Rebel Alliance won its most crucial victory over the Galactic Empire."
endor.save

dagobah = Homeworld.find_by name: "Dagobah"
dagobah.img_url = "https://lumiere-a.akamaihd.net/v1/images/Dagobah_890df592.jpeg?region=391%2C39%2C830%2C467"
dagobah.bio = "Home to Yoda during his final years, Dagobah was a swamp-covered planet strong with the Force -- a forgotten world where the wizened Jedi Master could escape the notice of Imperial forces. Characterized by its bog-like conditions and fetid wetlands, the murky and humid quagmire was undeveloped, with no signs of technology. Though it lacked civilization, the planet was teeming with life -- from its dense, jungle undergrowth to its diverse animal population. Home to a number of fairly common reptilian and amphibious creatures, Dagobah also boasted an indigenous population of much more massive -- and mysterious -- lifeforms. Surrounded by creatures generating the living Force, Yoda learned to connect with the deeper cosmic Force and waited for one who might bring about the return of the Jedi Order."
dagobah.save

yavin = Homeworld.find_by name: "Yavin IV"
yavin.img_url = "https://lumiere-a.akamaihd.net/v1/images/databank_yavin4_01_169_b6945e20.jpeg?region=0%2C0%2C1560%2C878&width=1536"
yavin.bio = "One of a number of moons orbiting the gas giant Yavin in the galaxy’s Outer Rim, Yavin 4 was a steamy world covered in jungle and forest. It was the location of the principal rebel base early in the Galactic Civil War, and the site from which the Rebellion launched the attack that destroyed the first Death Star – a confrontation known thereafter as the Battle of Yavin."
yavin.save

mustafar = Homeworld.find_by name: "Mustafar"
mustafar.img_url = "https://lumiere-a.akamaihd.net/v1/images/databank_mustafar_01_169_5b470758.jpeg?region=0%2C0%2C1560%2C878&width=1536"
mustafar.bio = "A tiny, fiery planet in the Outer Rim, Mustafar maintains an erratic orbit between two gas giants. Mustafar is rich in unique and valuable minerals which have long been mined by the Tech Union. Its lava pits and rivers make this planet a dangerous habitat; its natives have burly, tough bodies that can withstand extreme heat. The planet became the backdrop for the fateful duel between Obi-Wan Kenobi and Anakin Skywalker. After the rise of the Empire, captured Jedi were brought to the volcanic world for interrogation and execution."
mustafar.save

dantooine = Homeworld.find_by name: "Dantooine"
dantooine.img_url = "https://lumiere-a.akamaihd.net/v1/images/dantooine_f1c04676.jpeg?region=0%2C20%2C1560%2C878&width=1536"
dantooine.bio = "The site of the first base for the Rebel Alliance, Dantooine is an Outer Rim world, filled with lush forests and green landscapes. The Alliance would later leave Dantooine for a new home in an effort to stay one step ahead of the Empire."
dantooine.save

polis = Homeworld.find_by name: "Polis Massa"
polis.img_url = "https://lumiere-a.akamaihd.net/v1/images/databank_polismassa_01_169_21f04b76.jpeg?region=0%2C0%2C1560%2C878&width=1536"
polis.bio = "An obscure planetoid deep in the Outer Rim, Polis Massa nonetheless occupied an important place in galactic history: The Skywalker twins were born there and given names by their mother Padmé Amidala before she died. And plans made in secret on Polis Massa would one day determine the fate of the galaxy."
polis.save

geonosis = Homeworld.find_by name: "Geonosis"
geonosis.img_url = "https://lumiere-a.akamaihd.net/v1/images/databank_geonosis_01_169_1d04e086.jpeg?region=0%2C0%2C1560%2C878&width=1536"
geonosis.bio = "A harsh rocky world less than a parsec away from Tatooine, Geonosis is a ringed planet beyond the borders of the Galactic Republic. Its uninviting surface is made up of harsh, rocky desert, and the creatures that evolved on Geonosis are well equipped to survive in the brutal environment. The most advanced lifeform are the Geonosians, sentient insectoids that inhabit towering spire-hives. The Geonosians maintain large factories for the production of droids and weapons for the Separatist cause in the Clone Wars. After the Clone Wars, the Empire chose Geonosis as the construction site of the first Death Star, restricting travel to the system and sterilizing the planet’s surface."
geonosis.save
