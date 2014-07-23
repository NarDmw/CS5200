class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.references :poster
      t.references :responder
      t.references :posting

      t.timestamps
    end
    add_index :conversations, [:poster_id, :responder_id, :posting_id], unique: true, name: :conversation_idx
  end
end
