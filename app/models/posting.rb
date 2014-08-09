class Posting < ActiveRecord::Base
  has_one :review
  has_one :feedback_message
  has_many :conversations

  belongs_to :poster, class_name: :User
  belongs_to :responder, class_name: :User
  belongs_to :skill
  belongs_to :location
end
