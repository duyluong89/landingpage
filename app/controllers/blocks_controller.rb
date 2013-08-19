class BlocksController < ApplicationController
  def index
    @pageId = params[:pageId]
    @pageId = Integer(@pageId)
    @page = Page.getPage(@pageId)
    @page= Page.find(@page[0].id)
    @blocks = Block.getBlocksByPageId(@pageId)
  end
  def new
    @pageId = params[:pageId]
    @page = Page.find(@pageId)
    @block = Block.new

  end
  #start function creat block
  def create
    @block = Block.new(params[:block])
    if @block.save
      redirect_to :controller=>"blocks",:action=>"index",:pageId=>params[:block]["pageId"]
    else
      render 'new'
    end
  end
  #end function creat block
  def edit
    @blockId = params[:id]
    @a=Block.select('blocks.*,block_contents.id as id1,block_contents."blockId",block_contents."section1",block_contents."section2",block_contents."section3",block_contents."section4",block_contents."quote1",block_contents."quote2",block_contents."quote3",block_contents."languageCode"').
        joins('LEFT JOIN block_contents ON blocks.id = block_contents."blockId"').where("blocks.id=?",@blockId)
    @block = @a.find(@blockId)
    @page =Page.where("id=?",@block.pageId)
    @listLanguages = Language.all
    @listIcons =Icon.all
  end
  #start function update block
  def update
    @block = Block.find(params[:id])

    @paramsBlock = {"pageId"=>params[:block]["pageId"],"blockName"=>params[:block]["blockName"],"isAlternative"=>params[:block]["isAlternative"],"picture"=>params[:block]["picture"],"active"=>params[:block]["active"]  }

    if  params[:block]["id1"]==''
      @paramsBlockContent = {"blockId"=>@block.id,"section1"=>params[:block]["section1"],"section2"=>params[:block]["section2"],"section3"=>params[:block]["section3"],"section4"=>params[:block]["section4"],"quote1"=>params[:block]["quote1"],"quote2"=>params[:block]["quote2"],"quote3"=>params[:block]["quote3"],"languageCode"=>params[:block]["languageCode"]}
      @blockContent = BlockContent.new(@paramsBlockContent)
      @blockContent.save
      @msg = 'Successfully saved  !'
    else
      @paramsBlockContent = {"section1"=>params[:block]["section1"],"section2"=>params[:block]["section2"],"section3"=>params[:block]["section3"],"section4"=>params[:block]["section4"],"quote1"=>params[:block]["quote1"],"quote2"=>params[:block]["quote2"],"quote3"=>params[:block]["quote3"],"languageCode"=>params[:block]["languageCode"]}
      @id = Integer(params[:block]["id1"])
      @blockContent = BlockContent.find(@id)
      @blockContent.update_attributes(@paramsBlockContent)
    end
    @block.update_attributes(@paramsBlock)
    redirect_to  :controller=>"blocks",:action=>"index", :pageId=>params[:block]["pageId"]

  end
  #end function update block
  def destroy
    @block = Block.find(params[:id])
    @block.destroy
    redirect_to :back
  end
end
