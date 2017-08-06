class Homeworld < ApplicationRecord
  has_many :characters, dependent: :destroy
end
