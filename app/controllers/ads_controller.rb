class AdsController < ApplicationController
  def index
    @id = params[:id]
    @id = Integer(@id)
    @page = Page.getPage(@id)
    @page= Page.find(@page[0].id)
    @pages = Page.viewList('','','')
    @ads = Ad.getAdsesByPageId(@id)
    #render :text=>@ads.id.inspect

  end
  def duplicate
    @ad = Ad.find(params[:id])
    @adCopy = @ad.dup     # dup: duplicate
    @adCopy.name = @adCopy.name +  "-Copy"
    @adCopy.save
    redirect_to :back
  end
  def destroy
    @ad = Ad.find(params[:id])
    @ad.destroy
    redirect_to :back
  end
end
