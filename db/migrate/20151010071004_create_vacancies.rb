class CreateVacancies < ActiveRecord::Migration
  def change
    create_table :vacancies do |t|
      t.text :name, null: false
      t.date :available_to, null: false
      t.integer :salary, null: false
      t.text :phone
      t.text :email

      t.timestamps null: false
    end
    add_index :vacancies, :available_to
    add_index :vacancies, :salary, order: :desc

    create_join_table :vacancies, :skills do |t|
      t.index :vacancy_id
      t.index :skill_id
      t.index [:vacancy_id, :skill_id], unique: true
    end
  end
end
