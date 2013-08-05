class Privilege < ActiveRecord::Base
  attr_accessible :controller, :description, :privilege, :task
  
 def self.checkPrivilege _privilege, curentController,curentAction
   @listPrivilege = Privilege.where("controller = '#{curentController}' and task like '%#{curentAction}%' and privilege like '%#{_privilege}%'")
   if(@listPrivilege.count > 0) 
     return @listPrivilege
   else 
     return false
    end
 end 
end
## 1,50,100
## 1