class Posting < ActiveRecord::Base
  has_many :feedback_messages

  belongs_to :poster, class_name: :User
  belongs_to :responder, class_name: :User
  belongs_to :skill
  belongs_to :location
end
