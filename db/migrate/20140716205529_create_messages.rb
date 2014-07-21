class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :conversation, index: true
      t.string :message_header, limit: 45
      t.string :message_body, limit: 500

      t.timestamps
    end
  end
end
