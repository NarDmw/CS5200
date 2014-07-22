class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :skill_category, limit: 45
      t.string :skill_name, limit: 45
    end
  end
end
