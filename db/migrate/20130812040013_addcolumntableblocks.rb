class Addcolumntableblocks < ActiveRecord::Migration
  def up
    add_column :blocks ,:pageId,:int4
    add_column :blocks ,:blockName, :string
    add_column :blocks ,:isAlternative ,:int2
    add_column :blocks ,:picture ,:string
    add_column :blocks, :oder, :int2
    add_column :blocks, :active,:int2
  end
  def down
    remove_column :blocks, :pageId
    remove_column :blocks, :blockName
    remove_column :blocks, :isAlternative
    remove_column :blocks, :picture
    remove_column :blocks, :oder
    remove_column :blocks, :active

  end
end
