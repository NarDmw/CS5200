class Posting < ActiveRecord::Base
  belongs_to :poster
  belongs_to :responder
  belongs_to :skill
  belongs_to :location
end
