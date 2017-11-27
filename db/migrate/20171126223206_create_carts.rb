class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.integer :user
      t.integer :recipe

      t.timestamps null: false
    end
  end
end
