class AddPrivateToRecipe < ActiveRecord::Migration
  def change
    add_column :recipes, :private, :boolean, null: false
  end
end
