class Skill < ActiveRecord::Base
  has_many :user_skills
  has_many :users, through: :user_skills
  has_and_belongs_to_many :locations
  has_many :lsu, class_name: :LocationsSkillsUsers, dependent: :destroy

end
