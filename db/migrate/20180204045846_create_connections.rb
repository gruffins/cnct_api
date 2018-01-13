class CreateConnections < ActiveRecord::Migration[5.1]
  def change
    create_table :connections do |t|
      t.references :user
      t.references :other, references: :users
      t.integer :status, default: 0, null: false
      t.timestamps null: false
    end

    add_index :connections, :status
    add_index :connections, [:user_id, :other_id], unique: true
  end
end
