class CreateNetworks < ActiveRecord::Migration[5.1]
  def change
    create_table :networks do |t|
      t.belongs_to :device
      t.string :ssid_hash, null: false
      t.boolean :authorization, default: false, null: false
      t.integer :max_distance, default: 0, null: false
    end

    add_index :networks, :ssid_hash
  end
end
