class CreateProfiles < ActiveRecord::Migration[7.2]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true, index: { unique: true }
      t.string :name, null: false, limit: 20
      t.text :introduction
      t.integer :course, null: false, default: 0
      t.string :x_url
      t.string :github_url
      t.string :comment, limit: 80
      t.timestamps
    end
  end
end
