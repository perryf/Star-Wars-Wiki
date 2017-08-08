class CreateTransportations < ActiveRecord::Migration[5.1]
  def change
    create_table :transportations do |t|
      t.references :vehicle, index: true, foreign_key: true, null: false
      t.references :character, index: true, foreign_key: true, null: false
      t.timestamps
    end
  end
end
