class AddPictureToUsersRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :picture, :string
    add_column :users, :picture, :string
  end
end
