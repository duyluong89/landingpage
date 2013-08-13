class Addcolumntablepagetext < ActiveRecord::Migration
  def up
    add_column :page_texts, :pageId ,:int
    add_column :page_texts, :buttonText, :string
    add_column :page_texts, :message, :string
    add_column :page_texts, :languageCode, :string
    add_column :page_texts, :isDefault, :int2
  end

  def down
    remove_column :page_texts, :pageId
    remove_column :page_texts, :buttonText
    remove_column :page_texts, :message
    remove_column :page_texts, :languageCode
    remove_column :page_texts, :isDefault
  end
end
