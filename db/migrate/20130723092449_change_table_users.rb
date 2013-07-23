class ChangeTableUsers < ActiveRecord::Migration
  def up
    rename_column :users, :editAnalytics, :enabledAnalCode
    
  end

  def down
    rename_column :users, :enabledAnalCode, :editAnalytics
   
  end
end
