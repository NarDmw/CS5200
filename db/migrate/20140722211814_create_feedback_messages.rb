class CreateFeedbackMessages < ActiveRecord::Migration
  def change
    create_table :feedback_messages do |t|
      t.references :User, index: true
      t.references :Posting, index: true
      t.string :email, limit: 45
      t.text :body

      t.timestamps
    end
  end
end
