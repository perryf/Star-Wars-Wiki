class CreateCharacters < ActiveRecord::Migration[5.1]
  def change
    create_table :characters do |t|
      t.string :name, null: false
      t.string :species
      t.string :class, default: ""
      t.string :birth_year
      t.string :height
      t.string :mass
      t.text :bio, default: ""
      t.string :catch_phrase, default: ""
      t.string :img_url
      t.references :alliance, index: true, foreign_key: true
      t.timestamps
    end
  end
end
