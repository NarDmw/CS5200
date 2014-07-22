class CreateUserSkills < ActiveRecord::Migration
  def change
    create_table :user_skills do |t|
      t.references :skill, index: true
      t.references :user, index: true
      t.integer :proficiency_level

      t.timestamps
    end
    add_index :skills_users, [:skill_id, :user_id]
  end
end
