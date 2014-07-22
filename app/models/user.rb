class User < ActiveRecord::Base
  belongs_to :location

  validates :email, :user_name, uniqueness: true
end
