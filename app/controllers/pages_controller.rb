class PagesController < ApplicationController
  def index
    @pages = Page.all
  end

  def  new
    @page = Page.new
    @languages = Language.all
    @currentUser = session[:curentUser]
  end
  def create
    @page = Page.new(params[:page]) do |p|
      @a = ""
      @flag = 1
      @languageCodes = params[:page]["languages"]
      if (@languageCodes == nil)
        p.languages = "de"

      else
        @languageCodes.each do |l|
          @a += l
          if(@flag < @languageCodes.count)
            @a += ','
          end
          @flag +=1
        end
        p.languages = @a
      end

    end
    if @page.save
      redirect_to :action=>"index"
    else
      render 'new'
    end

  end
  # start function edit page
  def edit
    @pageid = params[:id]
    #@a=Page.select('page_texts."pageId",page_texts.message,page_texts."buttonText",page_texts.id as id1,pages.id,pages."pageName",pages.languages').joins('LEFT JOIN page_texts ON page_texts."pageId" = pages.id').where("pages.id=?",@pageid)
    @a=Page.select('pages.*,page_texts."pageId",page_texts.message,page_texts."buttonText",page_texts.id as id1').joins('LEFT JOIN page_texts ON pages.id = page_texts."pageId"').where("pages.id=?",@pageid)
    @page = @a.find(@pageid)
    @listlanguages = Language.all
  end
  # end function edit page
  # start function update page
  def update
    @page = Page.find(params[:id])
    @a = ""
    @flag = 1
    @lang = params[:page]["languages"]
    if (@lang == nil)
      @lang = "de"
    else
      @lang.each do |l|
        @a += l
        if(@flag < @lang.count)
          @a += ','
        end
        @flag +=1
      end
      params[:page]["languages"] = @a
    end

    @paramsPage = {"pageName"=>params[:page]["pageName"],"url"=>params[:page]["url"],"background"=>params[:page]["background"],"alterBackground"=>params[:page]["alterBackground"],"pageTitle"=>params[:page]["pageTitle"],
                   "analyticCode"=>params[:page]["analyticCode"],"useDefaultAnalytic"=>params[:page]["useDefaultAnalytic"],"useGlobalTutorial"=>params[:page]["useGlobalTutorial"],"displayCode"=>params[:page]["displayCode"],
                   "buttonUrl"=>params[:page]["buttonUrl"],"languages"=>params[:page]["languages"],"active"=>params[:page]["active"]
    }
    if  params[:page]["id1"]==''           #if not exits page_texts
      @paramsPageText = {"pageId"=>@page.id,"languageCode"=>params[:page]["languageCode"],"buttonText"=>params[:page]["buttonText"],"message"=>params[:page]["message"]}
      @pageText = PageText.new(@paramsPageText)
      @pageText.save
    else
      @paramsPageText = {"languageCode"=>params[:page]["languageCode"],"buttonText"=>params[:page]["buttonText"],"message"=>params[:page]["message"]}
      @id = Integer(params[:page]["id1"])
      @pageText = PageText.find(@id)
      @pageText.update_attributes(@paramsPageText)
    end
    @page.update_attributes(@paramsPage)
      redirect_to  :action=>"index", :id=>@page.id

  end
  # end function update
  # start function delete page
  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    redirect_to :action=>"index"
  end
  # end function delete page
  # start function duplicate page
  def duplicate
   @page = Page.find(params[:id])
   @pageCopy = @page.dup     # dup: duplicate
     @pageCopy.pageName = @pageCopy.pageName +  "-Copy"
   @pageCopy.save
   redirect_to :action=>"index"
  end
  # end function duplicate page
  def elfinder
    h, r = ElFinder::Connector.new(
        :root => File.join(Rails.public_path, 'system', 'open_gallery'),
        :url => '/system/elfinder',
        :perms => {
            'forbidden' => {:read => false, :write => false, :rm => false},
            /README/ => {:write => false},
            /pjkh\.png$/ => {:write => false, :rm => false},
        },
        :extractors => {
            'application/zip' => ['unzip', '-qq', '-o'],
            'application/x-gzip' => ['tar', '-xzf'],
        },
        :archivers => {
            'application/zip' => ['.zip', 'zip', '-qr9'],
            'application/x-gzip' => ['.tgz', 'tar', '-czf'],
        },
        :thumbs => true
    ).run(params)

    headers.merge!(h)
    render (r.empty? ? {:nothing => true} : {:text => r.to_json}), :layout => false
  end
end