class AddSpeciesToCharacters < ActiveRecord::Migration[5.1]
  def change
    add_reference :characters, :specie, index: true, foreign_key: true
  end
end
