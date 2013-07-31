class Privilege < ActiveRecord::Base
  attr_accessible :controller, :description, :privilege, :task
  
 def self.checkPrivilege _privilege
   #Privilege.where()
 end 
end
