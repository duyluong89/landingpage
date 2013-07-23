class ChangeUserTable < ActiveRecord::Migration
  def up
    rename_column :users, :userLever, :privilege
    rename_column :users, :active, :status
    rename_column :users, :created_at, :createdDate
    rename_column :users, :updated_at, :lastVisitDate
  end

  def down
    rename_column :users, :privilege, :userLever
    rename_column :users, :status, :active 
    rename_column :users, :createdDate, :created_at 
    rename_column :users, :lastVisitDate, :updated_at 
  end
end
