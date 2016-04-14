class AddRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, default: 0
  end
end
