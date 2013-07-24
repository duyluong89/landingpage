class UpdateDataTableUsers < ActiveRecord::Migration
  def up
    remove_column :users, :status, :enabledAnalCode
    add_column :users, :status, :integer
    add_column :users, :enabledAnalCode, :integer
  end

  def down
    add_column :users, :status, :boolean, :enabledAnalCode, :boolean
    remove_column :users, :status, :enabledAnalCode
  end
end
