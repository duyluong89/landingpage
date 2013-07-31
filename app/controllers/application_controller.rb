class ApplicationController < ActionController::Base
  protect_from_forgery
   
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
  
  
end
