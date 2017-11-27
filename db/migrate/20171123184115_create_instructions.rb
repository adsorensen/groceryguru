class CreateInstructions < ActiveRecord::Migration
  def change
    create_table :instructions do |t|
      t.belongs_to :recipe, index: true, foreign_key: true, null: false
      t.belongs_to :ingredient, index: true, foreign_key: true, null: false
      t.integer :amount, null: false
      t.integer :unit
      t.string :prep_note, null: false

      t.timestamps
    end
  end
end
