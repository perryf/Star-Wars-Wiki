class Homeworld < ApplicationRecord
  has_many :characters, dependent: :destroy
  has_many :species, dependent: :destroy
end
