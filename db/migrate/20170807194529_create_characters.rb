class CreateCharacters < ActiveRecord::Migration[5.1]
  def change
    create_table :characters do |t|
      t.string :name, null: false
      t.string :classification, default: ""
      t.string :birth_year
      t.integer :height
      t.integer :mass
      t.text :bio, default: ""
      t.string :catch_phrase, default: ""
      t.string :img_url
      t.string :films
      t.string :url
      t.references :alliance, index: true, foreign_key: true
      t.references :homeworld, index: true, foreign_key: true
      t.references :species, index: true, foreign_key: true
      # good job using the foreign_key constraint
      # however, you do not need to specify index: true as t.references will automatically
      # add this constraint
      # you would want to specify it if you used t.integer :species_id 
      t.timestamps
    end
  end
end
