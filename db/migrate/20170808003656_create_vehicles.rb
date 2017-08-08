class CreateVehicles < ActiveRecord::Migration[5.1]
  def change
    create_table :vehicles do |t|
      t.string :name
      t.string :img_url
      t.string :model
      t.string :manufacturer
      t.bigint :cost_in_credits
      t.bigint :cargo_capacity
      t.string :vehicle_class
      t.string :max_atmosphering_speed
      t.bigint :crew
      t.bigint :passengers
      t.float :length
      t.string :films
      t.string :url
      t.timestamps
    end
  end
end
