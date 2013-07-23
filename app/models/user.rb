class User < ActiveRecord::Base
  attr_accessible :active, :description, :editAnalytics, :email, :name, :password, :userLever, :username
end
