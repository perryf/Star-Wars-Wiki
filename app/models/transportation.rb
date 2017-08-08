class Transportation < ApplicationRecord
  belongs_to :characters
  belongs_to :vehicles
end
