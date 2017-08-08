class Vehicle < ApplicationRecord
  has_many :transportations
  has_many :characters, through: :transportations
end
