class MakeIngNameUniqueChangeUnit < ActiveRecord::Migration
  def change
    add_index :ingredients, :name, :unique => true
    change_column :instructions, :unit, :string
  end
end
