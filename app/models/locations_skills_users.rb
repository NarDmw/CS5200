class LocationsSkillsUsers < ActiveRecord::Base
  belongs_to :location
  belongs_to :skill
  belongs_to :user
end
