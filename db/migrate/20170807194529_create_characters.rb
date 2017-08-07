class CreateCharacters < ActiveRecord::Migration[5.1]
  def change
    create_table :characters do |t|
      t.string :name, null: false
      t.string :classification, default: ""
      t.string :birth_year
      t.integer :height
      t.integer :mass
      t.string :vehicles
      t.text :bio, default: ""
      t.string :catch_phrase, default: ""
      t.string :img_url
      t.string :films
      t.string :url
      t.references :alliance, index: true, foreign_key: true
      t.references :homeworld, index: true, foreign_key: true
      t.references :species, index: true, foreign_key: true
      t.timestamps
    end
  end
end
