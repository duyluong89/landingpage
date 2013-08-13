class Changecolumnodertableblocks < ActiveRecord::Migration
  def up
    rename_column :blocks, :oder, :order
  end

  def down
    rename_column :blocks, :order, :oder
  end
end
