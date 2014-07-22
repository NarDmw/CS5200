class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :category, limit: 45
      t.string :name, limit: 45

      t.timestamps
    end
  end
end
