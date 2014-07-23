class Skill < ActiveRecord::Base
  has_many :user_skills
  has_many :users, through: :user_skills

  has_and_belongs_to_many :locations
end
