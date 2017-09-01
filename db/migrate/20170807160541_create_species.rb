class CreateSpecies < ActiveRecord::Migration[5.1]
  def change
    create_table :species do |t|
      t.string :name
      t.string :img_url
      t.string :designation
      t.string :classification
      t.integer :average_height
      t.integer :average_lifespan
      # for the two above, you may want to use :decimal
      t.string :skin_colors
      t.string :language
      t.string :films
      t.string :url
      t.references :homeworld, index: true, foreign_key: true
      t.timestamps
    end
  end
end
