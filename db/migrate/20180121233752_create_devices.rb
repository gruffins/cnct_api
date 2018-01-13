class CreateDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :devices do |t|
      t.belongs_to :user
      t.uuid :uuid, null: false
      t.timestamps null: false
    end

    add_index :devices, :uuid, unique: true
  end
end
