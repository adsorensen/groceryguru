class AddPrepTimeServings < ActiveRecord::Migration
  def change
    add_column :recipes, :servings, :int
    add_column :recipes, :prep_time, :int
  end
end
