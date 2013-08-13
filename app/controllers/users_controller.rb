class UsersController < ApplicationController
  
  before_filter :checkAuthentication,:checkAccess , :only=>['index', 'new', 'edit','destroy']
  
  def index
    @user =  User.order(:name).page(params[:page]).per(10)
   
  end
 
  def new
    @user = User.new
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
      render :action=>"new"
    end
  end
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
 
    if @user.update_attributes(params[:user])
      redirect_to :action=>"index"
    else
      render 'edit'
    end
  end
  
 def destroy
   @user = User.find(params[:id])
   @user.destroy
   redirect_to users_path
  end
  
  def login
      render :layout => "login"
  end
  
  def dologin
    @username = params[:user]["username"]
    @password = params[:user]["password"]
    @login = User.checkLogin(@username,@password)
    if @login
        setCurentUser(@login)
       redirect_to :action=>"index"
    else redirect_to :action=>"login"
    end
    
  end
  
  def logout
    setCurentUser(nil)
    redirect_to :action=>"login"
  end
  
  def denied
    
  end
  
end
