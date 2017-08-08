class Transportation < ApplicationRecord
  belongs_to :character
  belongs_to :vehicle
end
