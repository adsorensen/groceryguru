class CreateInstructions < ActiveRecord::Migration
  def change
    create_table :instructions do |t|
      t.belongs_to :recipes, index: true
      t.belongs_to :units, index: true
      t.belongs_to :prep_notes, index: true
      t.belongs_to :ingredients, index: true
      t.int :amount

      t.timestamps null: false
    end
  end
end
