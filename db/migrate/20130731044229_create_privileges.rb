class CreatePrivileges < ActiveRecord::Migration
  def change
    create_table :privileges do |t|
      t.string :controller
      t.string :task
      t.string :privilege
      t.string :description

      t.timestamps
    end
  end
end
