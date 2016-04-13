class AddCategoriesToTools < ActiveRecord::Migration
  def change
    add_reference :tools, :category, index: true
  end
end
