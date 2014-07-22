class CreatePostings < ActiveRecord::Migration
  def change
    create_table :postings do |t|
      t.references :user, index: true
      t.references :user, index: true
      t.references :skill, index: true
      t.references :location, index: true
      t.string :header, limit: 45
      t.text :body
      t.boolean :open_posting
      t.boolean :is_request
      t.integer :days_duration

      t.timestamps
    end
  end
end
