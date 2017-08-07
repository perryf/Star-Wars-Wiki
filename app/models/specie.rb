class Specie < ApplicationRecord
  belongs_to :homeworld
  has_many :characters
end
