class Alliance < ApplicationRecord
  has_many :characters, dependent: :destroy
end
