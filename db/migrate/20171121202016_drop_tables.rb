class DropTables < ActiveRecord::Migration
  def change
    drop_table :recipes
    drop_table :units
    drop_table :prep_notes
    drop_table :ingredients
  end
end
