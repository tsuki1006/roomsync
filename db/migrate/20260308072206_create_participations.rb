class CreateParticipations < ActiveRecord::Migration[7.2]
  def change
    create_table :participations do |t|
      t.references :schedule, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
    add_index :participations, [:schedule_id, :user_id], unique: true
  end
end
