class AddTagsToRecipe < ActiveRecord::Migration
  def change
    add_column :recipes, :tags, :string
  end
end
