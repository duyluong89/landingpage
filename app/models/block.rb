class Block < ActiveRecord::Base
  attr_accessible :pageId, :blockName,:isAlternative,:picture, :oder, :active
  def self.getBlocksByPageId(pageId)
    @block = Block.where('"pageId"=?', pageId)
    return @block
  end
end
