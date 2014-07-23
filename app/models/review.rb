class Review < ActiveRecord::Base
  belongs_to :reviewer
  belongs_to :reviewee
  belongs_to :posting
end
