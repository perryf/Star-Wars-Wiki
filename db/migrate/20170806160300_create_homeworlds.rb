class CreateHomeworlds < ActiveRecord::Migration[5.1]
  def change
    create_table :homeworlds do |t|
      t.string :name, null: false
      t.string :climate
      t.string :terrain
      t.integer :population
      t.integer :gravity
      t.integer :films
      t.timestamps
    end
  end
end
