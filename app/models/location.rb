class Location < ActiveRecord::Base
  has_and_belongs_to_many :skills
  has_many :users, dependent: :destroy
  has_many :lsu, class_name: :LocationsSkillsUsers, dependent: :destroy
end
