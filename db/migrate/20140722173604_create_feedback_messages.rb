class CreateFeedbackMessages < ActiveRecord::Migration
  def change
    create_table :feedback_messages do |t|
      t.string :contact_email
      t.string :name
      t.string :body

      t.timestamps
    end
  end
end
