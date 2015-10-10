class CreateApplicants < ActiveRecord::Migration
  def change
    create_table :applicants do |t|
      t.text :name, null: false
      t.text :phone
      t.text :email
      t.integer :is_active, null: false, default: 1
      t.integer :salary, null: false

      t.timestamps null: false
    end
    add_index :applicants, :is_active
    add_index :applicants, :salary

    create_join_table :applicants, :skills do |t|
      t.index :applicant_id
      t.index :skill_id
      t.index [:applicant_id, :skill_id], unique: true
    end

  end
end
