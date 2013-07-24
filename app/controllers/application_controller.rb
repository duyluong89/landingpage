class ApplicationController < ActionController::Base
  protect_from_forgery
  $currentUser = nil
  
  
  def check_Authentication
    if $currentUser == nil
      #render :layout=>"login"
    end
  end
end
