class User < ActiveRecord::Base
  belongs_to :location
  has_many :user_skills
  has_many :skills, through: :user_skills
  has_many :lsu, class_name: :LocationsSkillsUsers, dependent: :destroy
  has_many :posting_posts, dependent: :destroy, class_name: :Posting, foreign_key: :poster_id
  has_many :posting_responses, class_name: :Posting, foreign_key: :responder_id

  has_many :conversation_posts, class_name: :Conversation, foreign_key: :poster_id
  has_many :conversation_responses, class_name: :Conversation, foreign_key: :responder_id

  has_many :messages_sent, class_name: :Message, foreign_key: :sender_id
  has_many :messages_received, class_name: :Message, foreign_key: :recipient_id

  validates :email, :user_name, uniqueness: true
end
