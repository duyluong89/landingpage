class UsersController < ApplicationController
  def index
    @user = User.all
  end
  
  def show
    
  end
  def new
    @user = User.new
    #render :text=>Time.now
  end
  
  def create
    @user = User.new(params[:post]) do |u|
      u.createdDate = Time.now  
      u.lastVisitDate = Time.now
    end
    
    
    if @user.save
      redirect_to :action=>"index"
    else
      
    end
  end
end
