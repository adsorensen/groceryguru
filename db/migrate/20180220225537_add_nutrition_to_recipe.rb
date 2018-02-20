class AddNutritionToRecipe < ActiveRecord::Migration
  def change
    add_column :recipes, :calories, :decimal
    add_column :recipes, :fat, :decimal
    add_column :recipes, :saturated_fat, :decimal
    add_column :recipes, :carbs, :decimal
    add_column :recipes, :cholestrol, :decimal
    add_column :recipes, :sugar, :decimal
    add_column :recipes, :sodium, :decimal
    add_column :recipes, :protein, :decimal
  end
end
