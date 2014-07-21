class CreateLocationsSkills < ActiveRecord::Migration
  def change
    create_table :locations_skills, index: false do |t|
      t.references :location, index: true
      t.references :skill, index: true
      t.references :user, index: true
    end
  end
end
