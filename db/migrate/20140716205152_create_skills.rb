class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.references :SkillCategory, index: true
      t.string :skill_name, limit: 45
    end
  end
end
