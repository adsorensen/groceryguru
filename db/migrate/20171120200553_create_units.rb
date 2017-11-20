class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :unit

      t.timestamps null: false
    end
    create_table :prep_notes do |t|
      t.string :note

      t.timestamps null: false
    end
    create_table :ingredients do |t|
      t.string :ingredient

      t.timestamps null: false
    end
  end
end
