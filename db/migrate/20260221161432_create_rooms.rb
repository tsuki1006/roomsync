class CreateRooms < ActiveRecord::Migration[7.2]
  def change
    create_table :rooms do |t|
      t.references :creator, null: false, foreign_key: { to_table: :users }
      t.string :name, null: false, limit: 50
      t.string :room_key_digest
      t.text :description
      t.timestamps
    end
    add_index :rooms, :name, unique: true
  end
end
