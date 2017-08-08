class CreateVehicles < ActiveRecord::Migration[5.1]
  def change
    create_table :vehicles do |t|
      t.string :name
      t.string :model
      t.string :manufacturer
      t.integer :cost_in_credits
      t.integer :cargo_capacity
      t.string :vehicle_class
      t.string :max_atmosphering_speed
      t.integer :crew
      t.integer :passengers
      t.float :length
      t.string :films
      t.string :url
      t.timestamps
    end
  end
end
