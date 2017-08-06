class CreateHomeworlds < ActiveRecord::Migration[5.1]
  def change
    create_table :homeworlds do |t|
      t.string :name, null: false
      t.string :bio
      t.string :img_url
      t.string :climate
      t.string :terrain
      t.string :population
      t.string :gravity
      t.string :films
      t.timestamps
    end
  end
end
