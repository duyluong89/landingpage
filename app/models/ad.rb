class Ad < ActiveRecord::Base
  attr_accessible :pageId, :name, :order,:hasContactButton, :active
  def self.getAdsesByPageId(pageId)
    @ad = Ad.where('"pageId"=?', pageId)
    return @ad
  end
end
