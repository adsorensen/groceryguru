class AddProductForeignKeyToIngredients < ActiveRecord::Migration
  def change
    add_column :ingredients, :product_id, :int
    add_foreign_key :ingredients, :products
  end
end
