class Posting < ActiveRecord::Base
  belongs_to :user
  belongs_to :user
  belongs_to :skill
  belongs_to :location
end
