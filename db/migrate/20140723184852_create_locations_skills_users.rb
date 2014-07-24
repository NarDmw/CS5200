class CreateLocationsSkillsUsers < ActiveRecord::Migration
  def change
    create_table :locations_skills_users do |t|
      t.references  :location, index: true
      t.references  :skill, index: true
      t.references  :user, index: true
      t.integer     :proficiency_level
    end
  end
end
