class Posting < ActiveRecord::Base
  belongs_to :poster, class_name: :User
  belongs_to :responder, class_name: :User
  belongs_to :skill
  belongs_to :location
end
