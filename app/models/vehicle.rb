class Vehicle < ApplicationRecord
  has_many :characters, through: :transportations
end
