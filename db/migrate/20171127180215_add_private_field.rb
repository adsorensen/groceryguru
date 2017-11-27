class AddPrivateField < ActiveRecord::Migration
  def change
    add_column :saved_recipes, :private, :boolean
  end
end
