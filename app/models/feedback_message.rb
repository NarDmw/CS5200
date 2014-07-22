class FeedbackMessage < ActiveRecord::Base
  belongs_to :User
  belongs_to :Posting
end
