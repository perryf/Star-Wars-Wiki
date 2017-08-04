# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "swapi"

Alliance.destroy_all
Character.destroy_all

characters_data = Swapi.get_all "people"

characters = Characters.create([{
  character_data.each do |character|
    name: character["name"],
    species: character.species,
    birth_year: character.birth_year,
    height: character.height,
    mass: character.mass
  end
  },])
