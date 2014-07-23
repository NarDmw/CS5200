class CreateUserSkills < ActiveRecord::Migration
  def change
    create_table :user_skills do |t|
      t.references :skill
      t.references :user
      t.integer :proficiency_level

      t.timestamps
    end
    add_index :user_skills, [:skill_id, :user_id]
  end
end
