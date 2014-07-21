class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.references :user, index: true
      t.references :user, index: true
      t.references :posting, index: true

      t.timestamps
    end
  end
end
