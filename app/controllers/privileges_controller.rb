class PrivilegesController < ApplicationController
   before_filter :checkAuthentication , :only=>['index', 'new', 'edit','destroy']
  def index
    @privilege = Privilege.all
  end

  def new
    #render :text=> controller_path()
    #return
    @privilege = Privilege.new
  end

  def create
    @privilege = Privilege.new(params[:privilege]) do |p|
      @pri = params[:privilege]["privilege"]
      @pri = @pri.split('-')
      @strPrivilege = ""
      @index = 0;
      @pri.each do |i|
        i.each do |j|
          @strPrivilege += j.to_str 
          if(i.count-1 > @index)
            @strPrivilege += ","
         end
          @index +=1
        end
        
      end
      p.privilege = @strPrivilege
    end
    
    if @privilege.save
      redirect_to :action=>"index"
    else
      render "new"
    end
  end
  def edit
    @privilege = Privilege.find(params[:id])
  end

  def update
    @privilege = Privilege.find(params[:id])
 
    if @privilege.update_attributes(params[:privilege])
      redirect_to @privilege
    else
      render 'edit'
    end
  end
  
  def destroy
    @privilege = Privilege.find(params[:id])
    @privilege.destroy
   redirect_to privileges_path
  end
end
