# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
Alliance.destroy_all
Character.destroy_all

rebels = Alliance.create!({
  name: "Rebels",
  img_url: "http://a.dilcdn.com/bl/wp-content/uploads/sites/6/2015/11/rebel-symbol.jpg"
})

imperials = Alliance.create!({
  name: "Imperials",
  img_url: "http://a.dilcdn.com/bl/wp-content/uploads/sites/6/2016/02/imperialseal.jpg"
})

neutral = Alliance.create!({
    name: "Neutral"
})

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
      films: planet["films"]
      })
  end
end

87.times do |i|
  begin
    person = JSON.parse(Swapi.get_person(i + 1))
  rescue => e
    puts e
  else
    Character.create!({
    name: person["name"],
    species: person["species"],
    birth_year: person["birth_year"],
    height: person["height"],
    mass: person["mass"],
    vehicles: person["vehicles"] + person["starships"],
    films: person["films"],
    homeworld: person["homeworld"],
    alliance: rebels,
    })
  end
end


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
