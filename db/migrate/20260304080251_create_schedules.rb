class CreateSchedules < ActiveRecord::Migration[7.2]
  def change
    create_table :schedules do |t|
      t.references :creator, null: false, foreign_key: { to_table: :users }
      t.references :room, null: false, foreign_key: true
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.string :comment, limit: 50
      t.integer :status, null: false, default: 0
      t.timestamps
    end
    add_index :schedules, :start_time
  end
end
