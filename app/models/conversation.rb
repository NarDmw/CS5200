class Conversation < ActiveRecord::Base
  belongs_to :user
  belongs_to :user
  belongs_to :posting
end
