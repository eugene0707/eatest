class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.text :name, null: false

      t.timestamps null: false
    end
    add_index :skills, :name, unique: true
  end
end
