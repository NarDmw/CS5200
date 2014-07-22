class User < ActiveRecord::Base
  belongs_to :location

  has_many :user_skills
  has_many :skills, through: :user_skills

  validates :email, :user_name, uniqueness: true
end
