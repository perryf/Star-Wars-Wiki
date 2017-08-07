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

#Characters Create
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
    Character.create!({
    name: person["name"],
    birth_year: person["birth_year"],
    height: person["height"],
    mass: person["mass"],
    vehicles: person["vehicles"] + person["starships"],
    films: person["films"],
    url: person["url"],
    alliance: rebel,
    homeworld: planet,
    species: species
    })
  end
end

darth = Character.find_by name: "Darth Vader"
darth.alliance = imperial
darth.img_url = "https://lumiere-a.akamaihd.net/v1/images/Darth-Vader_6bda9114.jpeg?region=0%2C23%2C1400%2C785"
darth.save

emperor = Character.find_by name: "Palpatine"
emperor.alliance = imperial
emperor.img_url = "https://lumiere-a.akamaihd.net/v1/images/Emperor-Palpatine_7ac4a10e.jpeg?region=0%2C0%2C1600%2C900&width=1536"
emperor.save

luke = Character.find_by name: "Luke Skywalker"
luke.img_url = "https://lumiere-a.akamaihd.net/v1/images/open-uri20150608-27674-1ymefwb_483d5487.jpeg?region=0%2C0%2C1200%2C675"
luke.save

yoda = Character.find_by name: "Yoda"
yoda.img_url = "https://lumiere-a.akamaihd.net/v1/images/Yoda-Retina_2a7ecc26.jpeg?region=0%2C0%2C1536%2C864"
yoda.save


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
