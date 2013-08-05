class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :checkAction
   
  def getCurentUser
    return session[:curentUser]
  end
  
  def setCurentUser(curentUser)
    session[:curentUser] = curentUser
  end
  
  private
  def checkAuthentication
    if session[:curentUser].present? 
       return true
     else
       redirect_to :controller => "users", :action => "login"
       return false
    end
  end
  
   def checkAccess
    @curentUser = session[:curentUser]
    @curentController = params[:controller]
    @curentAction = params[:action]
    if(@privilege = Privilege.checkPrivilege(@curentUser.privilege, @curentController, @curentAction))
      session[:task] = @privilege
      return true
    else
       redirect_to :controller=>"users", :action=>"denied"
       return false
    end
  end
   
   def checkAction(actionName)
     @task = session[:task]
       @task.each do |t|
          @arrTask =t.task.split(',')
          if(@arrTask.include?(actionName))
            return true
          end
       
     end
     return false
   end
   
  
end
