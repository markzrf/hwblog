class User < ActiveRecord::Base
  attr_accessible :login, :password
  has_many :posts
  has_many :comments
  def self.authenticate(login,password)
    user = User.find_by_login_and_password(login,password)
    if user
      return user
    else
      return false
    end
  end
end
