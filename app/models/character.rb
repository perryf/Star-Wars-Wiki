class Character < ApplicationRecord
  belongs_to :alliance
  belongs_to :homeworld
  belongs_to :specie
end
