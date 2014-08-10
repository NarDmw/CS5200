class Location < ActiveRecord::Base
  has_many :lsu, class_name: :LocationsSkillsUsers, dependent: :destroy
  has_many :skills, through: :lsu
  has_many :users, dependent: :destroy
  has_many :postings

  validates :city, :state, presence: true

  def to_s
    "#{city}, #{state}"
  end
end
