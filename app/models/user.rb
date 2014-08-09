class User < ActiveRecord::Base
  belongs_to :location

  has_many :skills, through: :lsu
  has_many :lsu, class_name: :LocationsSkillsUsers, dependent: :destroy

  has_many :posting_posts, dependent: :destroy, class_name: :Posting, foreign_key: :poster_id
  has_many :posting_responses, class_name: :Posting, foreign_key: :responder_id

  has_many :conversation_posts, class_name: :Conversation, foreign_key: :poster_id
  has_many :conversation_responses, class_name: :Conversation, foreign_key: :responder_id

  has_many :messages_sent, class_name: :Message, foreign_key: :sender_id
  has_many :messages_received, class_name: :Message, foreign_key: :recipient_id

  has_many :feedback_messages
  has_many :reviews

  validates :first_name, :last_name, :user_name, :email, presence: true
  validates :email, :user_name, uniqueness: true

  #TODO: remove before showing
  #validate :custom_secret_validation

  has_secure_password

  private
  def custom_secret_validation
    unless user_name.start_with?('test') && password == 'CS5200'
      errors.add(:user_name, 'Custom Secret Validation: Only certain parameter combination allowed to prevent database spam')
    end
  end
end
