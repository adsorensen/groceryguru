class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name, null: false
      t.text :instructions, null: false
      t.string :description
      t.string :origin

      t.timestamps null: false
    end
  end
end
