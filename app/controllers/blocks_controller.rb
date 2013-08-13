class BlocksController < ApplicationController
  def index
    @id = params[:id]
    @id = Integer(@id)
    @page = Page.getPage(@id)
    @page= Page.find(@page[0].id)
    #@pages = Page.viewList('','','')
    @blocks = Block.getBlocksByPageId(@id)
  end
  def destroy
    @block = Block.find(params[:id])
    @block.destroy
    redirect_to :back
  end
end
