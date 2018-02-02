class CreateCheckoutLists < ActiveRecord::Migration
  def change
    create_table :checkout_lists do |t|
      t.belongs_to :user, index: true, foreign_key: true, null: false
      t.belongs_to :ingredient, foreign_key: true, null: false
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
