class CreatePrepNotes < ActiveRecord::Migration
  def change
    create_table :prep_notes do |t|
      t.string :note

      t.timestamps null: false
    end
  end
end
