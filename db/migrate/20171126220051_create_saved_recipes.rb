class CreateSavedRecipes < ActiveRecord::Migration
  def change
    create_table :saved_recipes do |t|
      t.belongs_to :recipe, index: true, foreign_key: true, null: false
      t.belongs_to :user, index: true, foreign_key: true, null: false
      t.boolean :personal

      t.timestamps null: false
    end
  end
end
