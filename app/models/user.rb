class User < ActiveRecord::Base
  
  attr_accessible :status, :description, :enabledAnalCode, :email, :name, :password, :userLever, :username
  
  def self.checkLogin(username,password)
    @password = encryptPassword(password)
    @user = User.where("username='#{username}' and password='#{@password}'").first
      return @user
  end
  
  def self.encryptPassword(password)
    return Digest::MD5.hexdigest(password)
  end
  
  def self.getCurentUser
    return session[:curentUser]
  end
  
  def self.setCurentUser(curentUser)
    session[:curentUser] = curentUser
  end
end
