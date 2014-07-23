class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :reviewer, index: true
      t.references :reviewee, index: true
      t.references :posting, index: true
      t.text :body
      t.integer :rating

      t.timestamps
    end
  end
end
