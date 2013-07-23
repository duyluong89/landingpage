class ChangeTypeColumnTableUser < ActiveRecord::Migration
  def up
    remove_column :users, :enabledAnalCode
    add_column :users, :enabledAnalCode, :integer
    add_column :users, :leaderId, :integer
  end

  def down
    remove_column :users, :enabledAnalCode
    add_column :users, :enabledAnalCode, :boolean
    remove_column :users, :leaderId
  end
end
