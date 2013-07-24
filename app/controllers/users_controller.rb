class UsersController < ApplicationController
  
  #before_filter :check_Authentication
  
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
      u.password = User.encryptPassword(params[:post]["password"])
    end
     
    if @user.save
      redirect_to :action=>"index"
    else
      #render :text=>"ádadadada"
    end
  end
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
 
    if @user.update(params[:user])
      redirect_to :action=>"index"
    else
      render 'edit'
    end
  end
  
  def login
    if $currentUser == nil
      render :layout => "login"
    else redirect_to :action=>"index" 
    end
  end
  
  def dologin
    @username = params[:user]["username"]
    @password = params[:user]["password"]
    @login = User.checkLogin(@username,@password)
    if @login
      $currentUser = @login
       redirect_to :action=>"index"
    else redirect_to :action=>"login"
    end
    
  end
  
  def logout
    $currentUser = nil
    redirect_to :action=>"login"
  end
  
end
