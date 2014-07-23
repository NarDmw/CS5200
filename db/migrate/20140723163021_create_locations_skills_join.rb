class CreateLocationsSkillsJoin < ActiveRecord::Migration
  def change
    create_table :locations_skills, id: false do |t|
      t.references :location
      t.references :skill
    end
    add_index :locations_skills, [:location_id, :skill_id]
  end
end
