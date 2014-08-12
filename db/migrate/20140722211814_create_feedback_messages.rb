class CreateFeedbackMessages < ActiveRecord::Migration
  def change
    create_table :feedback_messages do |t|
      t.references :user, index: true
      t.references :posting, index: true
      t.string :email, limit: 45
      t.text :body
      t.boolean :viewed, default: false

      t.timestamps
    end
  end
end
