class Page < ActiveRecord::Base
  attr_accessible :pageName, :url, :background, :alterBackground, :pageTitle, :analyticCode, :useDefaultAnalytic, :useGlobalTutorial, :displayCode, :buttonUrl, :languages, :active,:pageOwner
  has_many :page_texts
  def self.checkLanguages(languages,l)
     if languages.include?(l)
       return true
     else
       return false
     end
   end
  def self.getPage(id)
    @page = Page.where('"id"=?',id)
    return @page
  end
  def self.viewList(ssUser, ssUserId, ssPrivilege)

    if ssPrivilege == 50
     @pages = Page.WHERE('pageOwner =? OR pageOwner IN (SELECT username FROM tbl_user WHERE leaderId =?)',ssUser,ssUserId)
    elsif  ssPrivilege == 100
      Page.WHERE('pageOwner =?',ssUser)
    else
      @pages = Page.all
    end
  return @pages
  end

end
