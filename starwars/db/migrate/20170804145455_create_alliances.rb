class CreateAlliances < ActiveRecord::Migration[5.1]
  def change
    create_table :alliances do |t|

      t.timestamps
    end
  end
end
