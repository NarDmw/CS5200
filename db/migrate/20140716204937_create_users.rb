class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.references :location, index: true
      t.string :user_name, limit: 45
      t.string :first_name, limit: 45
      t.string :last_name, limit: 45
      t.string :email, limit: 45
      t.boolean :prime_user, default: false
      t.boolean :is_admin, default: false
      t.float :avg_rating, default: 0.0

      t.timestamps
    end
  end
end
