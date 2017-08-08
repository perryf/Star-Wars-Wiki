class Character < ApplicationRecord
  belongs_to :alliance
  belongs_to :homeworld
  belongs_to :species
  has_many :transportations
  has_many :vehicles, through: :transportations
end
