class WelcomeController < ApplicationController
  def index
    @num_records = Review.count + User.count + Conversation.count + Message.count + Location.count +
        Posting.count + FeedbackMessage.count + LocationsSkillsUsers.count + Skill.count
  end
end