class CreateAlliances < ActiveRecord::Migration[5.1]
  def change
    create_table :alliances do |t|
      t.string :name, null: false
      t.string :img_url
      t.timestamps
    end
  end
end
