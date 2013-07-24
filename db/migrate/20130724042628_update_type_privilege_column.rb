class UpdateTypePrivilegeColumn < ActiveRecord::Migration
  def up
    remove_column :users, :privilege
    add_column :users, :privilege, :integer
  end

  def down
    remove_column :users, :privilege
    add_column :users, :privilege, :string
  end
end
