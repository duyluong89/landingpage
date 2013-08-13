class PageText < ActiveRecord::Base
  attr_accessible :pageId, :buttonText, :message, :languageCode, :isDefault
  #attr_protected
  belongs_to :pages
  def self.getPageTextByPageId(pageId,languageCode)
      @pagetext = PageText.where('"pageId"=? and "languageCode" = ?', pageId,"#{languageCode}")
      return @pagetext
  end
end
