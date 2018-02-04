class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.references :recipe
      t.references :meal_plan

      t.timestamps null: false
    end
  end
end
