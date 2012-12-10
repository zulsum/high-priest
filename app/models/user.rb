class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :validatable

  attr_accessible :username, :email, :password, :password_confirmation

  validates_presence_of :username
  validates_uniqueness_of :username
end
