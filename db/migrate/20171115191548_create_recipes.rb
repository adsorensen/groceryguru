class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :description
      t.text :ingredients
      t.string :instructions
      t.string :note
      t.string :tags
      t.string :origin

      t.timestamps null: false
    end
  end
end
