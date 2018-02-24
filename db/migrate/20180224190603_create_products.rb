class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.float :price, null: false
      t.string :walmart_url
      t.string :kroger_url
      t.string :brand, null: false
      t.integer :ttl, null: false

      t.timestamps null: false
    end
  end
end
