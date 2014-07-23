class User < ActiveRecord::Base
  belongs_to :location

  has_secure_password
end
