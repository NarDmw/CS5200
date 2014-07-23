class CreatePostings < ActiveRecord::Migration
  def change
    create_table    :postings do |t|
      t.references  :poster, index: true
      t.references  :responder, index: true
      t.references  :skill, index: true
      t.references  :location, index: true
      t.string      :header, limit: 100
      t.text        :body
      t.boolean     :open_posting, default: true
      t.boolean     :is_request, default: true
      t.integer     :days_duration, default: 7

      t.timestamps
    end
  end
end
