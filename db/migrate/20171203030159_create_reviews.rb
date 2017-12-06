class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.belongs_to :recipe, index: true, foreign_key: true, null: false
      t.belongs_to :user, index: true, foreign_key: true, null: false
      t.string :text, null: false
      t.integer :rating, null: false
      
      t.timestamps null: false
    end
  end
end
