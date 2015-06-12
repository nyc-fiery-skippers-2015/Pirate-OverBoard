class User < ActiveRecord::Base
  include BCrypt
  has_secure_password
  has_many :questions
  has_many :answers
  has_many :votes
  has_many :comments
end
