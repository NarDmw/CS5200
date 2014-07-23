class Conversation < ActiveRecord::Base
  belongs_to :poster, class_name: :User
  belongs_to :responder, class_name: :User
  belongs_to :posting
end
