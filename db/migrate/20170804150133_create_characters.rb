class CreateCharacters < ActiveRecord::Migration[5.1]
  def change
    create_table :characters do |t|
      t.string :name, null: false
      t.string :species
      t.string :class
      t.text :bio, default: ""
      t.string :catch_phrase, default: ""
      t.string :img_url
      t.timestamps
    end
  end
end
