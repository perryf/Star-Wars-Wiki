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
  name: "Rebels"
})

imperials = Alliance.create!({
  name: "Imperials"
})

neutral = Alliance.create!({
    name: "Neutral"
})

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
    homeworld: person["homeworld"],
    vehicles: person["vehicles"] + person["starships"],
    alliance: rebels
    })
  end
end
