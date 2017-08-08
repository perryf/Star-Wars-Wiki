# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
Alliance.destroy_all
Species.destroy_all
Homeworld.destroy_all
Character.destroy_all
Vehicle.destroy_all


rebel = Alliance.create!({
  name: "Rebels",
  img_url: "http://a.dilcdn.com/bl/wp-content/uploads/sites/6/2015/11/rebel-symbol.jpg"
})

imperial = Alliance.create!({
  name: "Imperials",
  img_url: "http://a.dilcdn.com/bl/wp-content/uploads/sites/6/2016/02/imperialseal.jpg"
})

neutral = Alliance.create!({
  name: "Neutral"
})

# Homeworlds Create
61.times do |i|
  begin
    planet = JSON.parse(Swapi.get_planet(i + 1))
  rescue => e
    puts e
  else
    Homeworld.create!({
      name: planet["name"],
      climate: planet["climate"],
      terrain: planet["terrain"],
      population: planet["population"],
      gravity: planet["gravity"],
      films: planet["films"],
      url: planet["url"]
    })
  end
end

homeworld_unknown = Homeworld.create!({
  name: "Unknown",
  url: ""
  })

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
    Species.create!({
      name: species["name"],
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
    Vehicle.create!({
      name: vehicle["name"],
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
    characters << Character.create!({
    name: person["name"],
    birth_year: person["birth_year"],
    height: person["height"],
    mass: person["mass"],
    films: person["films"],
    url: person["url"],
    alliance: rebel,
    homeworld: planet,
    species: species
    })
    vehicle = Vehicle.find_by url: person["vehicles"][0]
    character = Character.find_by name: person["name"]
    Transportation.create!(character: character, vehicle: vehicle)
  end
end

# sand = Vehicle.find_by name: "Sand Crawler"
#
# darth_in_sand = Transportation.create!(character: darth, vehicle: sand)

# characters.each do |person|
#   vehicle = Vehicle.find_by url: person.vehicles[0]
#   if (vehicle != nil && vehicle != "")
#     Transportation.create!(character: person, vehicle: vehicle)
#   else
#     Transportation.create!(character: person, vehicle: unknown_vehicle)
#   end
# end

darth = Character.find_by name: "Darth Vader"
darth.alliance = imperial
darth.img_url = "https://lumiere-a.akamaihd.net/v1/images/Darth-Vader_6bda9114.jpeg?region=0%2C23%2C1400%2C785"
darth.save

# sand = Vehicle.find_by name: "Sand Crawler"
#
# darth_in_sand = Transportation.create!(character: darth, vehicle: sand)

emperor = Character.find_by name: "Palpatine"
emperor.alliance = imperial
emperor.img_url = "https://lumiere-a.akamaihd.net/v1/images/Emperor-Palpatine_7ac4a10e.jpeg?region=0%2C0%2C1600%2C900&width=1536"
emperor.save

luke = Character.find_by name: "Luke Skywalker"
luke.alliance = rebel
luke.img_url = "https://lumiere-a.akamaihd.net/v1/images/open-uri20150608-27674-1ymefwb_483d5487.jpeg?region=0%2C0%2C1200%2C675"
luke.save

yoda = Character.find_by name: "Yoda"
yoda.alliance = rebel
yoda.img_url = "https://lumiere-a.akamaihd.net/v1/images/Yoda-Retina_2a7ecc26.jpeg?region=0%2C0%2C1536%2C864"
yoda.save

leia = Character.find_by name: "Leia Organa"
leia.alliance = rebel
leia.img_url = "https://lumiere-a.akamaihd.net/v1/images/open-uri20150608-27674-1ly2wd_eb4b4064.jpeg?region=0%2C0%2C1200%2C674"
leia.save

r2d2 = Character.find_by name: "R2-D2"
r2d2.alliance = rebel
r2d2.img_url = "https://lumiere-a.akamaihd.net/v1/images/r2-d2-featured_ba3d1867.jpeg?region=0%2C48%2C1536%2C768&width=1200"
r2d2.save

c3p0 = Character.find_by name: "C-3PO"
c3p0.alliance = rebel
c3p0.img_url = "https://lumiere-a.akamaihd.net/v1/images/C-3PO-See-Threepio_68fe125c.jpeg?region=0%2C1%2C1408%2C792"
c3p0.save

han_solo = Character.find_by name: "Han Solo"
han_solo.alliance = rebel
han_solo.img_url = "https://lumiere-a.akamaihd.net/v1/images/open-uri20150608-27674-nfid8t_2aab8189.jpeg?region=0%2C0%2C1200%2C674"
han_solo.save

chewie = Character.find_by name: "Chewbacca"
chewie.alliance = rebel
chewie.img_url = "https://lumiere-a.akamaihd.net/v1/images/chewie-db_2c0efea2.jpeg?region=54%2C154%2C1413%2C796"
chewie.save

# character_inputs = Character.create!([
#   {name: "Luke Skywalker",
#       alliance: rebels
#     },
#   {name: "Darth Vader",
#       alliance: imperials
#     },
#   {name: "Yoda",
#       alliance: rebels
#     },
#   {name: "Princess Lea",
#       alliance: rebels
#     },
#   {name: "Emperor Palpatine",
#       alliance: imperials
#     }
#   ])
