class AddUserIdToTools < ActiveRecord::Migration
  def change
    add_reference :tools, :user, index: true
  end
end
