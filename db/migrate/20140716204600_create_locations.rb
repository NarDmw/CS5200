class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :state, limit: 2
      t.string :city, limit: 50
    end
  end
end
