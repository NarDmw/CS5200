class LocationsSkillsUsers < ActiveRecord::Base
  belongs_to :location
  belongs_to :skill
  belongs_to :user

  private

  def self.create(user_id, location_id, skill_ids)
    lsu_array = []
    skill_ids.each do |skill_id|
      lsu_array << LocationsSkillsUsers.new(location_id: location_id, skill_id: skill_id, user_id: user_id)
    end
    LocationsSkillsUsers.import(lsu_array)
  end

  def self.edit(user_id, location_id, skills_id)
    #lazy, destroy all old ones
    LocationsSkillsUsers.where(user_id: user_id).destroy_all
    #create them all again
    LocationsSkillsUsers.create(user_id, location_id, skills_id)
  end
end
