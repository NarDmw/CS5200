class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.references :location, index: true
      t.string :user_name, limit: 45
      t.string :first_name, limit: 45
      t.string :last_name, limit: 45
      t.string :email, limit: 45
      t.integer :score, default: 0
      t.integer :num_responses, default: 0
      t.boolean :is_admin, default: false

      t.timestamps
    end
  end
end
