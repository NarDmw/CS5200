class User < ActiveRecord::Base
  belongs_to :location
  has_many :user_skills
  has_many :skills, through: :user_skills
  has_many :lsu, class_name: :LocationsSkillsUsers, dependent: :destroy
  has_many :p, dependent: :destroy, class_name: :Posting, foreign_key: :poster_id
  has_many :r, class_name: :Posting, foreign_key: :responder_id

  validates :email, :user_name, uniqueness: true
end
