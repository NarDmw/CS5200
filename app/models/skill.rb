class Skill < ActiveRecord::Base
  has_many :user_skills

  has_many :lsu, class_name: :LocationsSkillsUsers, dependent: :destroy
  has_many :users, through: :lsu
  has_many :locations, through: :lsu

  def to_s
    "#{category}: #{name}"
  end
end
