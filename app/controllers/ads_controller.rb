class AdsController < ApplicationController
  def index
    @pageId = params[:pageId]
    @pageId = Integer(@pageId)
    @page = Page.getPage(@pageId)
    @page= Page.find(@page[0].id)
    @pages = Page.viewList('','','')
    @ads = Ad.getAdsesByPageId(@pageId)

  end
  def  new
    @ad = Ad.new
    @listPages = Page.all
    @listLanguages = Language.all
    @pageId = params[:pageId]
    @page = Page.find(@pageId)
  end
  def create
    @paramsAd = {"pageId"=>params[:ad]["pageId"],"name"=>params[:ad]["name"],"hasContactButton"=>params[:ad]["hasContactButton"],"active"=>params[:ad]["active"]  }

    @ad = Ad.new(@paramsAd)
    @ad.save
    @ad_contents = params[:ad]["ad_contents"]
    @paramsAdContent = {"adsId"=>@ad.id,"ad1Content"=>@ad_contents["ad1Content"],"popupContent"=>@ad_contents["popupContent"],"cbExplanationText"=>@ad_contents["cbExplanationText"],
                        "cbPrefilledText"=>@ad_contents["cbPrefilledText"],"cbTargetEmail"=>@ad_contents["cbTargetEmail"],"cbButtonName"=>@ad_contents["cbButtonName"],"languageCode"=>params[:ad]["languageCode"]}
    @adContent = AdContent.new(@paramsAdContent)
    @adContent.save
    redirect_to  :controller=>"ads",:action=>"index", :pageId=>params[:ad]["pageId"]
  end
  def edit
    @adId = params[:id]
    @a=Ad.select('ads.*,ad_contents.id as id1,ad_contents."adsId",ad_contents."ad1Content",ad_contents."popupContent",ad_contents."cbExplanationText",ad_contents."cbPrefilledText",ad_contents."cbTargetEmail",ad_contents."cbButtonName",ad_contents."languageCode"').
        joins('LEFT JOIN ad_contents ON ads.id = ad_contents."adsId"').where("ads.id=?",@adId)
    @ad = @a.find(@adId)
    @listPages = Page.all
    @listLanguages = Language.all
    @listUser = User.all
  end
  def update
    @ad = Ad.find(params[:id])

    @paramsAd = {"pageId"=>params[:ad]["pageId"],"name"=>params[:ad]["name"],"hasContactButton"=>params[:ad]["hasContactButton"],"active"=>params[:ad]["active"]  }
    if  params[:ad]["id1"]==''
      @paramsAdContent = {"adsId"=>@ad.id,"ad1Content"=>params[:ad]["ad1Content"],"popupContent"=>params[:ad]["popupContent"],"cbExplanationText"=>params[:ad]["cbExplanationText"],"cbPrefilledText"=>params[:ad]["cbPrefilledText"],"cbTargetEmail"=>params[:ad]["cbTargetEmail"],"cbButtonName"=>params[:ad]["cbButtonName"],"languageCode"=>params[:ad]["languageCode"]}
      @adContent = AdContent.new(@paramsAdContent)
      @adContent.save
    else
      @paramsAdContent = {"ad1Content"=>params[:ad]["ad1Content"],"popupContent"=>params[:ad]["popupContent"],"cbExplanationText"=>params[:ad]["cbExplanationText"],"cbPrefilledText"=>params[:ad]["cbPrefilledText"],"cbTargetEmail"=>params[:ad]["cbTargetEmail"],"cbButtonName"=>params[:ad]["cbButtonName"],"languageCode"=>params[:ad]["languageCode"]}
      @id = Integer(params[:ad]["id1"])
      @adContent = AdContent.find(@id)
      @adContent.update_attributes(@paramsAdContent)
    end
    @ad.update_attributes(@paramsAd)
    redirect_to  :controller=>"ads",:action=>"index", :id=>@ad.pageId

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
