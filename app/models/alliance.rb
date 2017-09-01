class Alliance < ApplicationRecord
  has_many :characters, dependent: :destroy
  # good job using dependent destroy
end
